//
//  RSSFeed.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import Foundation

struct RSSFeed: Codable {
    let channel: RSSChannel
    
    enum CodingKeys: String, CodingKey {
        case channel = "channel"
    }
}

struct RSSChannel: Codable {
    let title: String?
    let items: [RSSItem]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case items = "item"
    }
}

struct RSSItem: Codable, Identifiable {
    var id = UUID() // Unique identifier for each article
    let title: String?
    var description: String?
    let link: String?
    let pubDate: String? // New field for publication date
    let enclosure: Enclosure? // To handle image URLs from Steam feed
    let mediaContent: MediaContent? // To handle image URLs from Dota2Times feed
    let dotabuffImage: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case link = "link"
        case pubDate = "pubDate"
        case enclosure = "enclosure" // For Steam feed images
        case mediaContent = "media:content" // For Dota2Times feed images
        case dotabuffImage = "dotabuff:image"
    }
    
    // Extract image URL based on the source of the feed
    var imageURL: String? {
        return enclosure?.url ?? mediaContent?.url ?? dotabuffImage
    }
    
    // A computed property to convert pubDate string to a Date object
    var formattedPubDate: Date? {
        guard let pubDate = pubDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return dateFormatter.date(from: pubDate)
    }
}

// For the <enclosure> tag (Steam feed)
struct Enclosure: Codable {
    let url: String?
    let length: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case length = "length"
        case type = "type"
    }
}

// For the <media:content> tag (Dota2Times feed)
struct MediaContent: Codable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}




