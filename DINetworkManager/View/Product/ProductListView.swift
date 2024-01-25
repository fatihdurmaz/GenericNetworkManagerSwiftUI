//
//  ProductListView.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 22.01.2024.
//

import SwiftUI
import SwiftUISnackbar
import SwipeCell
import SDWebImageSwiftUI

struct ProductListView: View {
    
    @StateObject var viewModel: ProductViewModel
    init(apiService:  ApiServiceProtocol) {
        _viewModel = StateObject(wrappedValue: ProductViewModel(productApiService: .init(apiService: apiService)))
    }
    let fakeProduct = Product(id: nil, title: "Deneme", description: "", price: 10, discountPercentage: 10, rating: 10, stock: 10, brand: "", category: "", thumbnail: "", images: [""])
    
    
    // Alternatif kullanım
    // @StateObject var viewModel = PostViewModel(postApiService: .init(apiService: AlamofireApiService.shared))
    
    var body: some View {
        
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.extraLarge)
                    .padding()
                    .background(.gray)
                    .tint(.white)
                    .clipShape(.rect(cornerRadius: 10))
                
                
            } else {
                List(viewModel.filteredProducts) { product in
                    
                    let button1 = SwipeCellButton(
                        buttonStyle: .titleAndImage,
                        title: "Delete",
                        systemImage: "trash",
                        titleColor: .white,
                        imageColor: .white,
                        view: nil,
                        backgroundColor: .red,
                        action: {
                            viewModel.deleteProduct(productId: product.id!)
                        },
                        feedback: true
                    )
                    
                    let button2 = SwipeCellButton(
                        buttonStyle: .titleAndImage,
                        title: "Update",
                        systemImage: "arrow.circlepath",
                        titleColor: .white,
                        imageColor: .white,
                        view: nil,
                        backgroundColor: .green,
                        action: {
                            viewModel.updateProduct(productId: product.id!, product: fakeProduct)
                        },
                        feedback: true
                    )
                    
                    let slot1 = SwipeCellSlot(slots: [button2,button1])
                    
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        HStack {
                            WebImage(url: URL(string: product.thumbnail))
                                .resizable()
                                .placeholder {
                                    Rectangle().foregroundColor(.gray)
                                }
                                .scaledToFit()
                                .cornerRadius(8)
                                .frame(width: 75, height: 75)
                            
                            
                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.title3)
                                
                                Text("Price: $\(String(format: "%.2f", product.discountPercentage))")
                                    .italic()
                            }
                        }
                        .swipeCell(cellPosition: .right, leftSlot: nil, rightSlot: slot1)
                    }
                }
                .searchable(text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .overlay {
                    if viewModel.filteredProducts.isEmpty {
                        ContentUnavailableView.search(text: viewModel.searchText)
                    }
                }
                .toolbar {
                    Button(action: {
                        viewModel.addProduct(product: fakeProduct)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .tint(.black)
                    })
                }
                
            }
        }
        .onAppear {
            if viewModel.isLoading {
                viewModel.fetchAllProducts()
            }
        }
        .snackbar(isShowing: $viewModel.isShowingSnackBar, title: viewModel.title, text: viewModel.message, style: viewModel.isError ? .error : .default)
    }
}

#Preview {
    ProductListView(apiService: AlamofireApiService.shared)
}
