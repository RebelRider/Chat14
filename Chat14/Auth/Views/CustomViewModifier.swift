//
//  CustomViewModifier.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 99, idealWidth: 222)
            .padding()
            .fontWeight(.bold)
            .foregroundColor(.white)
            .background(Color(.systemBlue))
            .cornerRadius(13)
            .padding(.top, 13)
            .padding(.horizontal, 33)
            
    }
}

struct CustomTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(13)
            .padding(.horizontal, 33)
    }
}
