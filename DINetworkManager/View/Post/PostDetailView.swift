//
//  PostDetailView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 12.01.2024.
//

import SwiftUI

struct PostDetailView: View {
    
    let post: Post
    
    var body: some View {
        NavigationStack {
            List {
                Text(post.title)
                    .bold()
                    .font(.subheadline)
                    
                Text(post.body)
                    .font(.footnote)

                
            }
            .navigationTitle("Post: \(post.id)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PostDetailView(post: Post(userId: 1, id: 1, title: "Başlık", body: "Mesaj"))
}
