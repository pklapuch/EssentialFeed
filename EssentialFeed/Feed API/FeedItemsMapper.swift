//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/26/22.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let imageURL: URL
        
        enum CodingKeys: String, CodingKey {
            case id
            case description
            case location
            case imageURL = "image"
        }
        
        var item: FeedItem {
            .init(id: id, description: description, location: location, imageURL: imageURL)
        }
    }

    private static var OK_200: Int { 200 }
    
    internal static func map(_ data: Data, _ resonse: HTTPURLResponse) throws -> [FeedItem] {
        guard resonse.statusCode == OK_200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        return try JSONDecoder().decode(Root.self, from: data).items.map { $0.item }
    }
}