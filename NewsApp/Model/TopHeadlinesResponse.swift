//
//  TopHeadlinesResponse.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import Foundation

struct TopHeadlinesResponse: Decodable {
    
    let status: String?
    
    let totalResults: Int?
    
    let message: String?
    
    let articles: [Article]?
    
}

struct Article: Decodable {
    
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let imgURL: String?
    
}

extension Article: Hashable {
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.source == rhs.source &&
            lhs.author == rhs.author &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.imgURL == rhs.imgURL
    }
    
}

extension Article {
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description
        case url
        case imgURL = "urlToImage"
    }
    
}

struct Source: Decodable {
    
    let id: String?
    
    let name: String?
    
}

extension Source: Hashable {
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
}
