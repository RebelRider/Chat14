//
//  NewMessageView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct NewMessageView: View {
    let didSelectUser: (User) -> ()
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = NewMessageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.users) { user in
                            Button {
                                dismiss()
                                didSelectUser(user)
                            } label: {
                                NewMessageCell(user: user)
                            }.buttonStyle(.plain)
                            
                            Divider()
                        }
                    }
                }
            }
            .padding(.top)
//            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }.buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NewMessageView(didSelectUser: { _ in })
}
