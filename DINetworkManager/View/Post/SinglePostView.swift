//
//  SinglePostView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 12.01.2024.
//

import SwiftUI

struct SinglePostView: View {
    @StateObject var viewModel = PostViewModel(postApiService: .init(apiService: AlamofireApiService.shared))
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Image(systemName: "book.pages")
                    Text(viewModel.post?.title ?? "Veri Yok")
                        .bold()
                        .font(.headline)
                }
                
                HStack {
                    Image(systemName: "paragraphsign")
                    Text(viewModel.post?.body ?? "Veri Yok")
                }
            }
            .onAppear{
                viewModel.fetchPostById(postId: 2)
            }
            .navigationTitle("Single Post")
        }
    }
}

#Preview {
    SinglePostView()
}
