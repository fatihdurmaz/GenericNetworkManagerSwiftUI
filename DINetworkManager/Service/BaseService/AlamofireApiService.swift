//
//  BaseService.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation
import Alamofire

class AlamofireApiService: ApiServiceProtocol {
    
    private init() { }
    
    static let shared = AlamofireApiService()
    
    // where neden kullanırız.
    func getRequest<T: Codable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
