# SwiftUI Generic Service with Alamofire and URLSession
![Swift](https://img.shields.io/badge/Swift-5.9%20%7C%205.8%20%7C%205.7-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7CMacOS-red.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

Bu örnek proje, SwiftUI kullanarak Dependency Injection (DI) ve Singleton tasarım desenini, MVVM ve Generic Network Manager oluşturmayı gösterir. 
Proje, Alamofire veya URLSession ile JSONPlaceholder API'den verileri çekmeyi amaçlar.

## ApiServiceProtocol Protocol

`ApiServiceProtocol` adlı bir protocol, ağ çağrıları yapmak için gerekli işlevselliği tanımlar.

```swift
protocol ApiServiceProtocol {
    func getRequest<T: Codable>(endpoint: String, completion: @escaping(Result<T, Error>) -> Void )
}
```
## AlamofireApiService Singleton Implementation
AlamofireApiService adlı sınıf, NetworkService protocolünü uygular ve bu sınıfı singleton olarak tasarlar.

```swift
class AlamofireApiService: ApiServiceProtocol {
    
    private init() { }
    
    static let shared = AlamofireApiService()
    
    func getRequest<T: Codable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint)
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
}
```

## URLSessionApiService Singleton Implementation
URLSessionApiService adlı sınıf, NetworkService protocolünü uygular ve bu sınıfı singleton olarak tasarlar.

```swift
class URLSessionApiService: ApiServiceProtocol {
    
    private init() { }
    
    static let shared = URLSessionApiService()
    
    func getRequest<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data not found", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
```

## UserViewModel
UserViewModel adlı ViewModel sınıfı, kullanıcıları çekmek ve kullanıcı arayüzünü güncellemek için kullanılır. Dependency Injection kullanılarak ApiServiceProtocol enjekte edilir.

```swift
class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    let userApiService: UserApiService
    
    init(userApiService: UserApiService) {
        self.userApiService = userApiService
    }
    
    func fetchUsers() {
        userApiService.getUsers { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

```
## SwiftUI içerisinde Kullanımı
Dependency Injection kullanılarak ApiServiceProtocol singleton olarak UserViewModel'e enjekte edilir ve bu ViewModel, UserListView tarafından kullanılır.
```swift
struct UserListView: View {
    
    @StateObject var viewModel: UserViewModel
    
    init(apiService:  ApiServiceProtocol) {
        _viewModel = StateObject(wrappedValue: UserViewModel(userApiService: .init(apiService: apiService)))
    }
    
    var body: some View {
        // ...
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                UserListView(apiService: URLSessionApiService.shared) // AlamofireApiService.shared olarak da değiştirebiliriz.
                //Hangi servis ile kullanacağımızı belirtiriz.
            }
            .navigationTitle("Generic Service")
        }
    }
}
```
