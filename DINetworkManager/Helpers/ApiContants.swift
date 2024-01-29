//
//  Contants.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

final class APIConstants {
    static let baseURL = URL(string: "https://dummyjson.com")!
    static let getProductEndpoint = baseURL.appending(path: "products")
}
