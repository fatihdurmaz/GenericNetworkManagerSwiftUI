//
//  ApiServiceProtocol.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 11.01.2024.
//

protocol ApiServiceProtocol {
    
    func getRequest<T: Codable>(endpoint: String, completion: @escaping(Result<T, Error>) -> Void )
}
