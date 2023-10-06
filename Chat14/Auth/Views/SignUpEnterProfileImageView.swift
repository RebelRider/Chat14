//
//  SignUpEnterProfileImageView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI
import PhotosUI

struct SignUpEnterProfileImageView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var isValidProfileImage: Bool {
        return viewModel.profileImage != nil
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("Add a profile image")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("This image will be displayed to other users.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 222, height: 222)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .clipShape(Circle())
                            .foregroundColor(Color(.systemGray6))
                            .frame(width: 222, height: 222)
                    }
                    
                    Text("Upload Profile Picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical, 8)
            .buttonStyle(.plain)
            
            NavigationLink {
                CreateUserView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Done")
                    .modifier(CustomButtonModifier())
            }
            .opacity(isValidProfileImage ? 1.0 : 0.9)
            .brightness(isValidProfileImage ? 0.0 : -0.2)
            .disabled(!isValidProfileImage)
            .buttonStyle(.plain)
            
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                }.buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    SignUpEnterProfileImageView().environmentObject(AuthViewModel())
}
