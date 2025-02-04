//
//  FlickrImage.swift
//  FlickrApp
//
//  Created by El Mero Mero on 1/31/25.
//

import Foundation

struct FlickrSearch: Decodable {
    let items: [FlickrSearchItem]
}

struct FlickrSearchItem: Decodable {
    let title: String
    let media: String
    let description: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case media = "media"
        case description = "description"
        case author = "author"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.author = try container.decode(String.self, forKey: .author)
        let mediaDict = try container.decode([String: String].self, forKey: .media)
        guard let mediaValue = mediaDict["m"] else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Media value not found"))
        }
        self.media = mediaValue
    }
}
