//
//  UserListView.swift
//  AlamofireGenericNetworkService
//

//  Created by Fatih Durmaz on 11.01.2024.
//

import SwiftUI
import SwiftUISnackbar
import SwipeCell

struct PostListView: View {
    
    //  constructor injection yöntemiyle DI yapıyoruz burada. PostListview kullanmak istediğimiz her yerde api servisi tanımlamak zorundayız
    @State private var share = false
    @State private var delete = false
    
    @StateObject var viewModel: PostViewModel
    init(apiService:  ApiServiceProtocol) {
        _viewModel = StateObject(wrappedValue: PostViewModel(postApiService: .init(apiService: apiService)))
    }
    
    // Alternatif kullanım
    //    @StateObject var viewModel = PostViewModel(postApiService: .init(apiService: AlamofireApiService.shared))
    
    var body: some View {
        List(viewModel.posts) { post in
            let button1 = SwipeCellButton(
                buttonStyle: .titleAndImage,
                title: "Share",
                systemImage: "square.and.arrow.up",
                titleColor: .white,
                imageColor: .white,
                view: nil,
                backgroundColor: .orange,
                action: {
                    //
                },
                feedback: true
            )
            let button2 = SwipeCellButton(
                buttonStyle: .titleAndImage,
                title: "Delete",
                systemImage: "trash",
                titleColor: .white,
                imageColor: .white,
                view: nil,
                backgroundColor: .red,
                action: {
                    viewModel.deletePost(postId: post.id)
                },
                feedback: true
            )
            let slot1 = SwipeCellSlot(slots: [button1, button2])
            
            NavigationLink(destination: PostDetailView(post: post)) {
                HStack {
                    Text("\(post.id)")
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .bold()
                            .font(.subheadline)
                    }
                }
                .swipeCell(cellPosition: .right, leftSlot: nil, rightSlot: slot1)
            }
        }
        .refreshable {
            viewModel.posts.removeAll()
            viewModel.fetchAllPosts()
        }
        .onAppear{
            viewModel.fetchAllPosts()
            //viewModel.fetchAllPosts(parameters: ["id":3])
            //viewModel.fetchAllPosts(parameters: ["userId":3])
        }
        .overlay {
            if viewModel.posts.isEmpty {
                ContentUnavailableView{
                    Label("No Results", systemImage: "tray.fill")
                        .bold()
                } description: {
                    Text("Not found posts")
                }
            }
        }
        
        .toolbar {
            Button(action: {
                let newPost = Post(userId: 2, id: 24, title: "Deneme", body: "Deneme İçeriği")
                viewModel.addPost(post: newPost)
                
            }, label: {
                Image(systemName: "plus.circle")
                    .tint(.black)
            })
        }
        .snackbar(isShowing: $viewModel.isShowing, title: viewModel.title, text: viewModel.message, style: viewModel.isError ? .error : .default)
    }
}

#Preview {
    PostListView(apiService: AlamofireApiService.shared)
}
