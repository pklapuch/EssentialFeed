//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/26/22.
//

import Foundation

public protocol HTTPClient {
    func getFrom(from url: URL)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.getFrom(from: url)
    }
}
