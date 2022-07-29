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
        
        var feed: [FeedItem] {
            return items.map { $0.item }
        }
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
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200 else { return .failure(RemoteFeedLoader.Error.invalidData) }
        
        do {
            let root = try JSONDecoder().decode(Root.self, from: data)
            return .success(root.feed)
        } catch {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
    }
}
