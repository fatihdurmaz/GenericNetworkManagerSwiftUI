//
//  ProductViewModel.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 22.01.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var product: Product?
    @Published var isShowing: Bool = false
    @Published var isError: Bool = false
    @Published var title = ""
    @Published var message = ""
    
    let productApiService: ProductApiService
    
    init(productApiService: ProductApiService) {
        self.productApiService = productApiService
    }
    
    func fetchAllProducts(parameters: [String: Any]? = nil) {
        productApiService.getAllProducts(parameters: parameters) { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchProductById(productId: Int) {
        productApiService.getProductById(productId: productId ) { result in
            switch result {
            case .success(let product):
                DispatchQueue.main.async {
                    self.product = product
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addProduct(product: Product) {
        productApiService.createProduct(product: product) { result in
            switch result {
            case .success():
                self.title = "Success"
                self.message = "Product added."
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
    
    func updateProduct(productId: Int, product: Product) {
        productApiService.updateProduct(productId: productId, product: product) { result in
            switch result {
            case .success:
                self.title = "Success"
                self.message = "Product \(productId) updated."
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
    
    func deleteProduct(productId: Int) {
        productApiService.deleteProduct(productId: productId) { result in
            switch result {
            case .success():
                self.title = "Success"
                self.message = "Product \(productId) deleted."
                self.isError = false
                
                if let index = self.products.firstIndex(where: { $0.id == productId }) {
                    self.products.remove(at: index)
                }
                
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
