//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/25/22.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable { }

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func loadItems(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
