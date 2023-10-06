//
//  SignUpView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct SignUpEnterEmailView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var isEmailVaid: Bool {
        return viewModel.email.contains("@") && viewModel.email.count > 4 && !viewModel.email.contains(" ")
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("Add your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this email to sign in to your account.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Email" , text: $viewModel.email)
                .modifier(CustomTextModifier())
            
            NavigationLink {
                SignUpEnterUsernameView()
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("Next")
                    .modifier(CustomButtonModifier())
            }
            .opacity(isEmailVaid ? 1.0 : 0.9)
            .brightness(isEmailVaid ? 0.0 : -0.2)
            .disabled(!isEmailVaid)
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
    SignUpEnterEmailView().environmentObject(AuthViewModel())
}
