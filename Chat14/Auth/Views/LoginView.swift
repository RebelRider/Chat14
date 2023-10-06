//
//  LoginView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var buttonDisabled = false
    
    var isLoginValid: Bool {
        email.contains("@") && email.contains(".") && password.count >= 6
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(systemName: "ellipsis.message")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 88, height: 88)
//                    .padding(44)
                Spacer()
                
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .modifier(CustomTextModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(CustomTextModifier())
                
                Button {
                    buttonDisabled = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        buttonDisabled = false
                        }
                    Task {
                        try await viewModel.login(email: email, password: password)
                    }
                } label: {
                    Text("LOGIN")
                        .modifier(CustomButtonModifier())
                }
                .opacity(isLoginValid ? 1.0 : 0.6)
                .brightness(isLoginValid ? 0.0 : -0.6)
                .disabled(!isLoginValid || buttonDisabled)
                .buttonStyle(.plain)
                
                
                Spacer()
                NavigationLink {
                    SignUpEnterEmailView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.black)
                        Text("Sign up").foregroundStyle(.blue)
                    }
                }.buttonStyle(.plain)
                
                Spacer()
                
            }//end VStack
        }
        
    }
}

#Preview {
    LoginView()
}
