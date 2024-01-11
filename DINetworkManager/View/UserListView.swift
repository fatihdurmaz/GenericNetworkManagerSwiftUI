//
//  UserListView.swift
//  AlamofireGenericNetworkService
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel: UserViewModel
    
    init(apiService:  ApiServiceProtocol) {
        _viewModel = StateObject(wrappedValue: UserViewModel(userApiService: .init(apiService: apiService)))
    }
    
    var body: some View {
        List(viewModel.users) { user in
            HStack {
                Text("\(user.id)")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(.circle)
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                        .italic()
                }
            }
        }
        .onAppear{
            Task {
                 viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UserListView(apiService: URLSessionApiService.shared)
}
