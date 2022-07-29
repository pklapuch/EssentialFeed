//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/25/22.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
