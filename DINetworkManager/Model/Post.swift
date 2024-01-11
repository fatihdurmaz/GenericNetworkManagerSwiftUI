//
//  Post.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

struct Post: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
