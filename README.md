# SwiftUI Generic Service with Alamofire and URLSession
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2017-red.svg)
![Platform](https://img.shields.io/badge/SwiftUI-4-green.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

This example project demonstrates Dependency Injection (DI) and Singleton design patterns using SwiftUI, along with creating a Generic Network Manager with MVVM.

The project aims to fetch data from a DummyJSON API using Alamofire or URLSession.

- [x] Desing Patterns
- [x] MVVM
- [x] Alamofire Api Service
- [ ] URLSession Api Service
- [ ] Auth
- [x] Generic Network Layer
- [x] UI Design
- [x] 3rd libraries

## Product Model

```swift
  struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int?
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
```

## ApiServiceProtocol Protocol

The protocol named ApiServiceProtocol defines the necessary functionality for making network calls.

```swift
protocol ApiServiceProtocol {
    func getRequest<T: Codable>(endpoint: URL, parameters: [String: Any]?, completion: @escaping(Result<T, Error>) -> Void )
    func addRequest<T: Codable>(endpoint: URL, data: T, completion: @escaping(Result<Void, Error>) -> Void)
    func updateRequest<T: Codable>(endpoint: URL, data: T, completion: @escaping(Result<Void, Error>) -> Void)
    func deleteRequest(endpoint: URL, completion: @escaping(Result<Void, Error>) -> Void)
}
```
## AlamofireApiService 
The class named AlamofireApiService implements the ApiService protocol and designs this class as a singleton.

```swift
class AlamofireApiService: ApiServiceProtocol {
    
    private init() { }
    
    static let shared = AlamofireApiService()
    
    func getRequest<T: Codable>(endpoint: URL, parameters: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint, method: .get, parameters: parameters)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // postRequest()
    // updateReques()
    // deleteRequest()
```

## ProductApiService
The class named ProductApiService performs network operations with the API service defined through Dependency Injection (DI), which is an instance implementing the ApiService protocol.

```swift
class ProductApiService{
    
    let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAllProducts(parameters: [String: Any]?, completion: @escaping (Result<[Product], Error>) -> Void ){ // tüm postları getirmek için
        apiService.getRequest(endpoint: APIConstants.getProductEndpoint, parameters: parameters) { (result: Result<ProductResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
// getProductById()
// createProduct()
// updateProduct()
// deleteProduct()
```

## ProductViewModel
The ProductViewModel is used to fetch products and update the product interface. It injects the ApiServiceProtocol using Dependency Injection.

```swift
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
}

// fetchProductById()
// addProduct()
// updateProduct()
// deleteProduct()

```
## View ile Kullanımı
The ApiServiceProtocol is injected into ProductViewModel as a singleton using Dependency Injection, and this ViewModel is used by the ProductListView.

```swift
struct ProductListView: View {
    
    @StateObject var viewModel: ProductViewModel
    init(apiService:  ApiServiceProtocol) {
        _viewModel = StateObject(wrappedValue: ProductViewModel(productApiService: .init(apiService: apiService)))
    }

    var body: some View {
        // ...
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ProductListView(apiService: AlamofireApiService.shared)
            }
            .navigationTitle("Products")
        }
    }
}
```
## Özellikler

- MVVM
- Singleton
- Dependency Injection
- Generic Network Layer
- Protocol Oriented Programming (POP)
- Alamofire & URLSession
- ContentUnavailableView
- SDWebImage
- SwipeActions
- .searchable modifier
- NavigationStack
