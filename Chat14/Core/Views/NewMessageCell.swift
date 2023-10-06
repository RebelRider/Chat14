//
//  NewMessageCell.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI
import Kingfisher

struct NewMessageCell: View {
    var user: User
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .shadow(radius: 3)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(user.username).font(.headline).foregroundColor(.black)
//                Text(user.email).font(.subheadline).foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    NewMessageCell(user: mockUsers.first!)
}
