//
//  BaseService.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import Foundation

class BaseService {
    
    private let host = "newsapi.org"
    
    func getURLRequest(path: String = "", queries: [URLQueryItem]? = nil, method: HTTPMethod) -> URLRequest? {
        
        let urlComponents = getURLComponent(path: path, queries: queries)
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.timeoutInterval = 60.0
        
        return request
    }
    
    private func getURLComponent(path: String, queries: [URLQueryItem]? = nil) -> URLComponents {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queries
        
        return urlComponents
    }
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
}
