//
//  ProductDetailView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 22.01.2024.
//

import SwiftUI
import SDWebImageSwiftUI
import StarRating

struct ProductDetailView: View {
    
    let product: Product
    @State var customConfig = StarRatingConfiguration(shadowRadius: 0)
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    ForEach(product.images, id: \.self) { imageUrl in
                        WebImage(url: URL(string: imageUrl))
                            .resizable() // Resizable like SwiftUI.Image, you must use this 
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .indicator(.activity) // Activity Indicator
                            .transition(.fade(duration: 0.5)) // Fade Transition with duration
                            .scaledToFit()
                            .cornerRadius(8)
                            .shadow(radius: 10)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9)
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
                    
                    HStack (alignment: .center) {
                        Text("Price: $\(String(format: "%.2f", product.discountPercentage))")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        StarRating(initialRating: product.rating, configuration: $customConfig)
                            .frame(width: 200,height: 30)
                        
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("In Stock: \(product.stock) units")
                            .foregroundColor(product.stock > 0 ? .green : .red)
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        
                        Text("Category: \(product.category)")
                            .bold()
                            .foregroundStyle(.orange)
                    }
                    Spacer()
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
