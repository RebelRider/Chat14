//
//  Message.swift
//  Chat14
//
//  Created by Kirill Smirnov on 06.10.2023.
//

import Foundation

struct Message: Identifiable {
    let id: String
    let fromId: String
    let toId: String
    let text: String
    let date: Date
}
