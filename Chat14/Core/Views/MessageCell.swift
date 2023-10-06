//
//  MessageCell.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct MessageCell: View {
    let message: Message
    let isFromCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                Text(message.text)
                    .foregroundColor(.white)
                    .padding(11)
                    .background(Color.blue)
                    .cornerRadius(22)
            } else {
                Text(message.text)
                    .foregroundColor(.black)
                    .padding(11)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(22)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    MessageCell(message: Message(id: "", fromId: "", toId: "", text: "Hello ;)", date: Date()), isFromCurrentUser: true)
}
