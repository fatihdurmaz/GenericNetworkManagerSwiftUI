//
//  Contants.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

class APIConstants {
    static let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    static let getPostEndpoint = baseURL.appending(path: "postsh")
}
