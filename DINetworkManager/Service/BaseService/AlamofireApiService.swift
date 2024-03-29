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
    
    func getRequest<T: Codable>(endpoint: URL, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint, method: .get, parameters: parameters)
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
    
    func addRequest<T: Codable>(endpoint: URL, data: T, completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(endpoint, method: .post, parameters: data, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func updateRequest<T: Codable>(endpoint: URL, data: T, completion: @escaping(Result<Void, Error>) -> Void) {
        AF.request(endpoint, method: .put, parameters: data, encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteRequest(endpoint: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request(endpoint, method: .delete)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
