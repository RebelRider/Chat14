//
//  HomeView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var currentUser: User
    
    @State private var showLogoutConfirmation = false
    @State private var showNewMessageView = false
    @State private var showMessageView = false
    
    @StateObject var messageViewModel: MessageViewModel
    @StateObject var homeViewModel: HomeViewModel
    
    init(currentUser: User) {
        self.currentUser = currentUser
        _messageViewModel = StateObject(wrappedValue: MessageViewModel(user: nil, currentUser: currentUser))
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(currentUser: currentUser))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 16) {
                    KFImage(URL(string: currentUser.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(50)
                        .overlay(
                        RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                        )
                        .shadow(radius: 3)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(currentUser.username)
                            .font(.system(size: 24))
                            .bold()
                        
                        Text(currentUser.email)
                            .font(.system(size: 12))
                            .foregroundColor(Color(.lightGray))
                    }
                    
                    Spacer()
                }
                .padding()
                
                Divider()
                
                ScrollView {
                    ForEach(homeViewModel.recentMessages) { message in
                        Button {
                            showMessageView.toggle()
                            Task {
                                await messageViewModel.fetchUser(uid: currentUser.uid == message.fromUid ? message.toUid : message.fromUid)
                            }
                        } label: {
                            RecentMessageCell(RecentMessage: message)
                        }
                        .buttonStyle(.plain)
                    }
                }//
                
                
                //
                NavigationLink("", destination: MessageView(viewModel: messageViewModel), isActive: $showMessageView).buttonStyle(.plain)
            }
            .buttonStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                    } label: {
                        Text("New message")
                    }.buttonStyle(.bordered)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showLogoutConfirmation.toggle()
                    } label: {
                        Text("Sign Out")
                    }.buttonStyle(.bordered)
                }
            }
            .alert(isPresented: $showLogoutConfirmation) {
                Alert(title: Text("Are you sure you want to sign out?"),
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("Sign Out"), action: authVM.signOut))
            }
            .fullScreenCover(isPresented: $showNewMessageView) {
                NewMessageView { user in
                    showMessageView.toggle()
                    messageViewModel.user = user
                    messageViewModel.fetchMessages()
                }
            }
        }
    }
}

#Preview {
    HomeView(currentUser: mockUsers.first!)
}
