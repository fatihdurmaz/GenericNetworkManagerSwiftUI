//
//  ContentView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                PostListView(apiService: AlamofireApiService.shared)
            }
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    ContentView()
}
