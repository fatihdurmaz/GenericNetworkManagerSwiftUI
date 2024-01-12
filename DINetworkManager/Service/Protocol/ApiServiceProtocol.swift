//
//  ApiServiceProtocol.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

protocol ApiServiceProtocol {
    
    func getRequest<T: Codable>(endpoint: URL, parameters: [String: Any]?, completion: @escaping(Result<T, Error>) -> Void )
    func addRequest<T: Codable>(endpoint: URL, data: T, completion: @escaping(Result<Void, Error>) -> Void)

}
