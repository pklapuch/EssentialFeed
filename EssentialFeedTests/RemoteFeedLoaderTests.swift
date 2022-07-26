//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 7/25/22.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "http://google.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    
    var requestedURL: URL?
    
    private init() { }
}

final class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestDataFromURL() {
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}
