//
//  UserApiService.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

class PostApiService{
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAllPosts(parameters: [String: Any]?, completion: @escaping (Result<[Post], Error>) -> Void ){ // tüm postları getirmek için
        apiService.getRequest(endpoint: APIConstants.getPostEndpoint, parameters: parameters) { (result: Result<[Post], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPostById(postId: Int, completion: @escaping (Result<Post, Error>) -> Void ){ // yalnızca bir post'u getirmek için
        apiService.getRequest(endpoint: APIConstants.getPostEndpoint.appending(path: "\(postId)"), parameters: nil) { (result: Result<Post, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createPost(post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        apiService.addRequest(endpoint: APIConstants.getPostEndpoint, data: post) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deletePost(postId: Int, completion: @escaping (Result<Void, Error>) -> Void) { // parametrik olarak da gerçekleştirebilirizi.
        apiService.deleteRequest(endpoint: APIConstants.getPostEndpoint.appending(path: "\(postId)")) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updatePost(postId: Int, newPostData: Post, completion: @escaping (Result<Void, Error>) -> Void) {
        apiService.updateRequest(endpoint: APIConstants.getPostEndpoint, identifier: postId, newData: newPostData) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
