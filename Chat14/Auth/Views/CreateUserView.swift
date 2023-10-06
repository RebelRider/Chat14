//
//  CreateUserView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct CreateUserView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var buttonDisabled = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text("Click Continue to get started")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding()
            
            Button {
                buttonDisabled = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    buttonDisabled = false
                    }
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                if buttonDisabled {
                    VStack {
                        Text("Please wait, loading your profile")
                        ProgressView().progressViewStyle(CircularProgressViewStyle()).scaleEffect(1.4)
                    }
                } else {
                HStack {
                    Image(systemName: "arrow.forward.circle.fill")
                        .imageScale(.large)
                    Text("Continue")
                        .font(.title)
                }
                .foregroundColor(.blue)
                }
            }
            .padding(.top, 2)
            .buttonStyle(.plain)
            .disabled(buttonDisabled)
            
            Spacer()
        }
    }
}

#Preview {
    CreateUserView().environmentObject(AuthViewModel())
}
