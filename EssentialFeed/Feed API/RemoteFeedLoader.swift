//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/26/22.
//

import Foundation

public protocol HTTPClient {
    func getFrom(from url: URL, completion:@escaping (Error) -> Void)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion:@escaping (Error) -> Void = { _ in }) {
        client.getFrom(from: url) { error in
            completion(.connectivity)
        }
    }
}
