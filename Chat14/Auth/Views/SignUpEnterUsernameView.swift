//
//  SignUpEnterUsernameView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct SignUpEnterUsernameView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var isValidUsername: Bool {
        return !viewModel.username.isEmpty && viewModel.username.count > 2
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("Create your username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("This username will be displated to other people.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Username", text: $viewModel.username)
                .modifier(CustomTextModifier())
            
            NavigationLink {
                SignUpEnterPasswordView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
                    .modifier(CustomButtonModifier())
            }
            .opacity(isValidUsername ? 1.0 : 0.9)
            .brightness(isValidUsername ? 0.0 : -0.2)
            .disabled(!isValidUsername)
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
    SignUpEnterUsernameView().environmentObject(AuthViewModel())
}
