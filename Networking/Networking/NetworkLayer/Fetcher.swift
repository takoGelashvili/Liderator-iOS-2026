//
//  Fetcher.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

import Foundation

final class Fetcher<T: Decodable> {
    static func request(with url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url else {
            completion(.failure(InvalidURLError()))
            return
        }
        
        URLSession(configuration: .default).dataTask(with: URLRequest(url: url)) { data, urlResponse, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(InvalidResponseError()))
                return
            }
            
            guard (200..<301).contains(urlResponse.statusCode) else {
                completion(.failure(WrongErrorCode()))
                return
            }
            
            guard let data else {
                completion(.failure(NoDataError()))
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(DecodingError()))
                return
            }
            
            completion(.success(decodedData))
        }.resume()
    }
}

struct InvalidURLError: Error {}
struct InvalidResponseError: Error {}
struct WrongErrorCode: LocalizedError {}
struct NoDataError: Error {}
struct DecodingError: Error {}

