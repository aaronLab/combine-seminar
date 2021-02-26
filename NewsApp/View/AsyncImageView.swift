//
//  AsyncImageView.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import SwiftUI

struct AsyncImageView: View {
    
    @ObservedObject private var imageLoader: ImageLoader
    @State private var image: UIImage = UIImage()
    
    init(urlString: String) {
        self.imageLoader = ImageLoader(urlString: urlString)
    }
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.didChage) { data in
                image = UIImage(data: data) ?? UIImage()
            }
        
    }
    
}
