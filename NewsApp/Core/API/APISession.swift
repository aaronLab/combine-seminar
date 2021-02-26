//
//  APISession.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import Foundation
import Combine

struct APISession: APIService {
    
    func request<T>(with request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: RunLoop.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in

                if let response = response as? HTTPURLResponse {

                    if (200...299).contains(response.statusCode) {

                        let decoder = JSONDecoder()
                        
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError { _ in .decodingError }
                            .eraseToAnyPublisher()
                        
                    } else {
                        
                        return Fail(error: .httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }

                }

                return Fail(error: .unknown)
                    .eraseToAnyPublisher()

            }
            .eraseToAnyPublisher()
        
    }
    
}
