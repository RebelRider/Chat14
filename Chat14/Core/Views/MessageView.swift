//
//  MessageView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: MessageViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            MessageCell(message: message, isFromCurrentUser: message.fromId == viewModel.currentUser.uid)
                        }
                        
                        HStack {
                            
                        }
                        .id("bottom")
                    }
                    .onReceive(viewModel.$count) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Enter Message", text: $viewModel.newMessageText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .cornerRadius(2)
                    .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                
                Button {
                    viewModel.sendNewMessage()
                } label: {
                    Text("Send")
                        .padding(.trailing)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.user?.username ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MessageView(viewModel: MessageViewModel(user: mockUsers.first, currentUser: mockUsers.last!))
}
