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
    @Published var isShowing: Bool = false
    @Published var isError: Bool = false
    @Published var title = ""
    @Published var message = ""
    
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
    
    func addPost(post: Post) {
        postApiService.createPost(post: post) { result in
            switch result {
            case .success():
                self.title = "Success"
                self.message = "Post added."
                self.isError = false
                
            case .failure(let error):
                print(error.localizedDescription)
                self.title = "Error"
                self.message = error.localizedDescription
                self.isError = true
                
            }
            self.isShowing = true
        }
    }
    
    func deletePost(postId: Int) {
        postApiService.deletePost(postId: postId) { result in
            switch result {
            case .success():
                self.title = "Success"
                self.message = "Post deleted."
                self.isError = false
                
                // JSONPlaceHolder da veriler gerçekten silinmediği için diziden silme işlemi yapıyoruz demo amaçlı.
                if let index = self.posts.firstIndex(where: { $0.id == postId }) {
                    self.posts.remove(at: index)
                }
                //

            case .failure(let error):
                print(error.localizedDescription)
                self.title = "Error"
                self.message = error.localizedDescription
                self.isError = true
            }
            self.isShowing = true
        }
    }
}
