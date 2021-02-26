//
//  TopHeadlinesService.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import Foundation
import Combine

final class TopHeadlinesEndpoint: BaseService {
    
    func getTopHeadlines(page: Int, pageSize: Int) -> URLRequest? {
        
        var queries: [URLQueryItem] {
            return [
                URLQueryItem(name: "country", value: "us"),
                URLQueryItem(name: "apiKey", value: APIKey),
                URLQueryItem(name: "pageSize", value: "\(pageSize)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
        
        return getURLRequest(path: "/v2/top-headlines", queries: queries, method: .get)
    }
    
}

protocol TopHeadlinesService {
    
    var apiSession: APIService { get }
    
    func getTopHeadlines(page: Int, pageSize: Int) -> AnyPublisher<TopHeadlinesResponse, APIError>
    
}

extension TopHeadlinesService {
    
    func getTopHeadlines(page: Int, pageSize: Int) -> AnyPublisher<TopHeadlinesResponse, APIError> {
        
        let endpoint = TopHeadlinesEndpoint().getTopHeadlines(page: page, pageSize: pageSize)
        
        guard let request = endpoint else {
            preconditionFailure("Invalid Request")
        }
        
        return apiSession.request(with: request)
        
    }
    
}
