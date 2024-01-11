//
//  UserApiService.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

class UserApiService{
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void ){
        apiService.getRequest(endpoint: "https://jsonplaceholder.typicode.com/users") { (result: Result<[User], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
