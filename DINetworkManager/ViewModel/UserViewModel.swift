//
//  UserViewModel.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    let userApiService: UserApiService
    
    init(userApiService: UserApiService) {
        self.userApiService = userApiService
    }
    
    func fetchUsers() {
        userApiService.getUsers { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
