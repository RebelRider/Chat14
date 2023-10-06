//
//  ContentView.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        
        if viewModel.currentUser == nil {
            LoginView().padding()
                .environmentObject(viewModel)
        } else if let currentUser = viewModel.currentUser {
            HomeView(currentUser: currentUser)
                            .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
}
