//
//  RSSFeedViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import Foundation
import XMLCoder
import SwiftSoup

class RSSFeedViewModel: ObservableObject {
    @Published var articles: [RSSItem] = []
    @Published var expandedArticle: String? = nil

    func fetchNews() {
        let steamRSSURL = URL(string: "https://store.steampowered.com/feeds/news/app/570/")!
        let dota2TimesRSSURL = URL(string: "https://dota2times.com/rss/google-news.xml")!
        let dotabuffURL = URL(string: "http://www.dotabuff.com/blog.rss")!
        
        let urls = [steamRSSURL, dota2TimesRSSURL, dotabuffURL]
        
        let group = DispatchGroup()
        var allArticles: [RSSItem] = []
        
        for url in urls {
            group.enter()
            fetchRSS(from: url) { items in
                allArticles.append(contentsOf: items)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // Sort articles by pubDate in descending order
            self.articles = allArticles.sorted(by: { $0.formattedPubDate ?? Date() > $1.formattedPubDate ?? Date() })
        }
    }
    
    private func fetchRSS(from url: URL, completion: @escaping ([RSSItem]) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = XMLDecoder()
                do {
                    let feed = try decoder.decode(RSSFeed.self, from: data)
                    let items = feed.channel.items.map { item in
                        var modifiedItem = item
                        if let rawDescription = item.description {
                            modifiedItem.description = self.stripHTML(rawDescription)
                        }
                        return modifiedItem
                    }
                    completion(items)
                } catch {
                    print("Error decoding RSS feed: \(error)")
                    completion([])
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
                completion([])
            }
        }.resume()
    }
    
    func stripHTML(_ html: String) -> String {
        do {
            let document = try SwiftSoup.parse(html)
            return try document.text()
        } catch {
            print("Error parsing HTML: \(error)")
            return html
        }
    }
    
    func toggleExpand(article: RSSItem) {
        if expandedArticle == article.title {
            expandedArticle = nil
        } else {
            expandedArticle = article.title
        }
    }
}




