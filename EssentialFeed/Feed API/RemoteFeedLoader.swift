//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/26/22.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion:@escaping (Result) -> Void) {
        client.getFrom(from: url) { result in
            switch result {
            case .success(let data, let response):
                do {
                    completion(.success(try FeedItemsMapper.map(data, response)))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
