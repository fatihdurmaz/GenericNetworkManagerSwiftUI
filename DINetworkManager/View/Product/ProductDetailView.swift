//
//  ProductDetailView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 22.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    let product: Product
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    ForEach(product.images, id: \.self) { imageUrl in
                        WebImage(url: URL(string: imageUrl))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .cornerRadius(8)
                            .shadow(radius: 8)
                            .padding()
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    Divider()
                    
                    HStack {
                        Text("Price: $\(String(format: "%.2f", product.discountPercentage))")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("Rating: \(String(format: "%.2f", product.rating))")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Divider()
                    
                    Text("In Stock: \(product.stock) units")
                        .foregroundColor(product.stock > 0 ? .green : .red)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    Text("Category: \(product.category)")
                        .bold()
                        .foregroundStyle(.teal)
                }
            }
            .padding()
            .navigationTitle(product.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProductDetailView(product: Product(id: 1, title: "", description: "", price: 100, discountPercentage: 100, rating: 4, stock: 100, brand: "", category: "", thumbnail: "", images: ["",""]))
}
