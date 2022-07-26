//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 7/25/22.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.getFrom(from: URL(string: "http://google.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient()

    func getFrom(from url: URL) { }
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    override func getFrom(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        
        let sut = RemoteFeedLoader()
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}
