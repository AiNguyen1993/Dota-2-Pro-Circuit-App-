//
//  NewsView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import SwiftUI

struct NewsRowView: View {
    var article: RSSItem
    @Binding var expandedArticle: String?
    var onExpand: (RSSItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title of the article
            Text(article.title ?? "Untitled")
                .font(.headline)
                .foregroundColor(.white)
                .bold()
            
            Text(article.pubDate ?? "Untitled")
                .font(.subheadline)
                .foregroundColor(.white)
                .opacity(0.7)
            
            // Image (if available)
            if let imageUrlString = article.imageURL, let imageUrl = URL(string: imageUrlString) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Show progress while loading
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .clipped()
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    case .failure:
                        Image("dota2_aegis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .foregroundColor(.gray)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
            // Description
            if let fullDescription = article.description {
                Text(expandedArticle == article.title ? formatDescription(fullDescription) : formatDescription(String(fullDescription.prefix(100)) + "..."))
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(expandedArticle == article.title ? nil : 3) // Allow expansion when "Read More" is clicked
                    .padding(.top, 5)
            } else {
                Text("No description available")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 5)
            }
            
            // Read more / show less button
            Button(action: {
                onExpand(article)
            }) {
                Text(expandedArticle == article.title ? "Show Less" : "Read More")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .bold()
                    .padding(.top, 5)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
    
    func formatDescription(_ description: String) -> String {
        // Replace double new lines or multiple spaces with a single paragraph break
        let formatted = description
            .replacingOccurrences(of: "\n\n", with: "\n") // Remove excessive new lines
            .replacingOccurrences(of: ". ", with: ".\n\n") // Add a paragraph after each sentence
        
        return formatted
    }
}

struct NewsView: View {
    @ObservedObject var viewModel = RSSFeedViewModel() // ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.articles) { article in
                        NewsRowView(
                            article: article,
                            expandedArticle: $viewModel.expandedArticle,
                            onExpand: { selectedArticle in
                                viewModel.toggleExpand(article: selectedArticle)
                            }
                        )
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationTitle("Dota 2 News")
            .onAppear {
                viewModel.fetchNews()
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea()
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .previewLayout(.sizeThatFits)
    }
}




