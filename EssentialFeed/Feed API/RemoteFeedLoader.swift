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
                completion(self.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            return .success(try FeedItemsMapper.map(data, response))
        } catch {
            return .failure(.invalidData)
        }
    }
}
