//
//  ProductApiService.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 22.01.2024.
//

import Foundation

class ProductApiService{
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAllProducts(parameters: [String: Any]?, completion: @escaping (Result<[Product], Error>) -> Void ){ // tüm postları getirmek için
        apiService.getRequest(endpoint: APIConstants.getProductEndpoint, parameters: parameters) { (result: Result<ProductResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProductById(productId: Int, completion: @escaping (Result<Product, Error>) -> Void ){ // yalnızca bir post'u getirmek için
        apiService.getRequest(endpoint: APIConstants.getProductEndpoint.appending(path: "\(productId)"), parameters: nil) { (result: Result<Product, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createProduct(product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        apiService.addRequest(endpoint: APIConstants.getProductEndpoint.appending(path: "add"), data: product) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateProduct(productId: Int, product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        apiService.updateRequest(endpoint: APIConstants.getProductEndpoint.appending(path: "\(productId)"), data: product) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteProduct(productId: Int, completion: @escaping (Result<Void, Error>) -> Void) { // parametrik olarak da gerçekleştirebilirizi.
        apiService.deleteRequest(endpoint: APIConstants.getProductEndpoint.appending(path: "\(productId)")) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
