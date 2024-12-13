//
//  NetworkManager.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 09/12/24.
//


import Foundation


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unknownError
}



class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        url: URL?,
        method: HTTPMethod = .get,
        body: Data? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(.failure(.unknownError))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    
    
    
    
    
    // Image download method
        func downloadImage(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
            guard let url = url else {
                completion(.failure(.invalidURL))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Image download error: \(error.localizedDescription)")
                    completion(.failure(.unknownError))
                    return
                }

                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(.failure(.serverError(response.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }

                completion(.success(data))
            }

            task.resume()
        }
    
}
