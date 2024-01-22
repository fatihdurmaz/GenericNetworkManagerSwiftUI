//
//  SinglePostView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 12.01.2024.
//

import SwiftUI

struct SingleProductView: View {
    @StateObject var viewModel = ProductViewModel(productApiService: .init(apiService: AlamofireApiService.shared))
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Image(systemName: "book.pages")
                    Text(viewModel.product?.title ?? "Veri Yok")
                        .bold()
                        .font(.headline)
                }
                
                HStack {
                    Image(systemName: "paragraphsign")
                    Text(viewModel.product?.description ?? "Veri Yok")
                }
            }
            .onAppear{
                viewModel.fetchProductById(productId: 1)
            }
            .navigationTitle("Single Product")
        }
    }
}

#Preview {
    SingleProductView()
}
