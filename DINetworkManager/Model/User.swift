//
//  User.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: Int
    let name, email: String
}
