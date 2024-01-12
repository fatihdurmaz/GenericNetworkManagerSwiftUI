//
//  UserViewModel.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import Foundation

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var post: Post?
    
    let postApiService: PostApiService
    
    init(postApiService: PostApiService) {
        self.postApiService = postApiService
    }
    
    func fetchAllPosts(parameters: [String: Any]? = nil) {
        postApiService.getAllPosts(parameters: parameters) { result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPostById(postId: Int) {
        postApiService.getPostById(postId: postId ) { result in
            switch result {
            case .success(let post):
                DispatchQueue.main.async {
                    self.post = post
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
