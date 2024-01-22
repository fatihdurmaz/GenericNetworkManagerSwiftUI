//
//  Product.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 22.01.2024.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int?
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
