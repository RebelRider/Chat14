//
//  AuthViewModel.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import PhotosUI
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    
    @Published var profileImage: Image?
    private var uiImage: UIImage? // only UIImage available to store with Firebase
        
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage()
            }
        }
    }
    
    @Published var currentUser: User?
    
    init() {
        Task {
            try await loadUserData()
        }
    }
    
    @MainActor func loadImage() async {
        guard let item = selectedImage else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    @MainActor func login(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            try await loadUserData() //?
        } catch {
            print("Failed to sign in user \(error.localizedDescription)")
        }
    }
    
    @MainActor func createUser() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let profileImageUrl = try await uploadImage(image: uiImage!, userUid: result.user.uid)
            await uploadUserData(uid: result.user.uid, username: username, email: email, profileImageUrl: profileImageUrl ?? "https://i.pinimg.com/736x/b9/96/f4/b996f4119f381e0270fce3008f3eeb9c.jpg")
            try await login(email: email, password: password)
        } catch {
            print("Failed to register user \(error.localizedDescription)")
        }
    }
    
    func uploadImage(image: UIImage, userUid: String) async throws  -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let ref = Storage.storage().reference(withPath: userUid)
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Failed to upload image \(error)")
            return nil
        }
    }
    
    @MainActor func uploadUserData(uid: String, username: String, email: String, profileImageUrl: String) async {
        let user = User(uid: uid, email: email, username: username, profileImageUrl: profileImageUrl)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        self.email = ""
        self.username = ""
        self.password = ""
        self.profileImage = nil
    }
    
    @MainActor func loadUserData() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        self.currentUser = try snapshot.data(as: User.self)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.currentUser = nil
    }
}
