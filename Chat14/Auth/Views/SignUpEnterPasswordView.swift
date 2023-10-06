//
//  SignUpEnterPasswordView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct SignUpEnterPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var isValidPassword: Bool {
        return viewModel.password.count >= 6
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this password to sign in to your account.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            SecureField("Password", text: $viewModel.password)
                .modifier(CustomTextModifier())
            
            NavigationLink {
                SignUpEnterProfileImageView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
                    .modifier(CustomButtonModifier())
            }
            .opacity(isValidPassword ? 1.0 : 0.9)
            .brightness(isValidPassword ? 0.0 : -0.2)
            .disabled(!isValidPassword)
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
    SignUpEnterPasswordView().environmentObject(AuthViewModel())
}
