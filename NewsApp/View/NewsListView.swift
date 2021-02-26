//
//  NewsListView.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/02/26.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject private var viewModel: NewsListViewModel
    
    @State private var destination = AnyView(EmptyView())
    @State private var navStatus: NavigationStatus? = .ready
    
    init() {
        self.viewModel = NewsListViewModel()
    }
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geo in
                
                ZStack {
                    
                    NavigationLink(
                        destination: destination,
                        tag: .pop,
                        selection: $navStatus,
                        label: {EmptyView()})
                    
                    ScrollView {
                        
                        LazyVStack(alignment: .leading, spacing: 16) {
                            
                            ForEach(viewModel.articles.indices, id: \.self) { index in
                                
                                let article = viewModel.articles[index]
                                
                                NewsCell(
                                    title: article.title ?? "",
                                    subTitle: "\(article.source?.name ?? "")/\(article.author ?? "")",
                                    url: article.url ?? ""
                                ) {
                                    guard let urlString = article.url else { return }
                                    popToWebView(urlString: urlString)
                                }
                                .padding()
                                .onAppear {
                                    viewModel.loadIfNeeded(with: article)
                                }
                                
                            }
                            
                        } //: V
                        
                    } //: S
                    
                    if viewModel.isLoading {
                        
                        Color.black.opacity(0.2)
                            .edgesIgnoringSafeArea(.all)
                        
                        ProgressView()
                        
                    }
                    
                } //: Z
                
            } //: G
            .navigationBarTitle("News", displayMode: .large)
            
        } //: N
        .onAppear {
            viewModel.getTopHeadLines()
        }
        
    }
    
    private func popToWebView(urlString: String) {
        destination = AnyView(
            WebView(urlString: urlString)
                .navigationBarTitle("Test")
        )
        
        DispatchQueue.main.async {
            navStatus = .pop
        }
    }
    
}

/// Navigation Link Status
enum NavigationStatus {
    case ready, pop
}

struct NewsCell: View {
    
    private let title: String
    private let subTitle: String
    private let url: String
    private let action: (() -> Void)?
    
    init(
        title: String,
        subTitle: String,
        url: String,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subTitle = subTitle
        self.url = url
        self.action = action
    }
    
    var body: some View {
        
        Button(action: {
            action?()
        }) {
            VStack(alignment: .leading, spacing: 16) {
                
                Text(title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                
                HStack {
                    Spacer(minLength: 0)
                    Text(subTitle)
                        .lineLimit(1)
                        .multilineTextAlignment(.trailing)
                        .font(.subheadline)
                } //: H
                
            } //: V
            .padding()
            .background(Color.gray.opacity(0.4))
        }
        
    }
    
}
