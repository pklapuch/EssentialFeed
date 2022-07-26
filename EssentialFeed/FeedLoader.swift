//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/25/22.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func loadItems(completion: @escaping (LoadFeedResult) -> Void)
}
