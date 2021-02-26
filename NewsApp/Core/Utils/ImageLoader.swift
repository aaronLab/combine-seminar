//
//  ImageLoader.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import Foundation
import Combine

final class ImageLoader: ObservableObject {
    
    var didChage = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChage.send(data)
        }
    }
    
    init(urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared
            .dataTask(with: url) { data, _, _ in
                
                guard let safeData = data else { return }
                
                DispatchQueue.main.async {
                    
                    self.data = safeData
                    
                }
                
            }
        
        task.resume()
        
    }
    
}
