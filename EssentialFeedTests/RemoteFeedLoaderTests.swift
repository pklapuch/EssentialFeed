//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Pawel Klapuch on 7/25/22.
//

import XCTest

class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.getFrom(from: url)
    }
}

protocol HTTPClient {
    func getFrom(from url: URL)
}

final class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestDataFromURL() {
        let url = URL(string: "https://google.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Helpers
    
    func makeSUT(url: URL = URL(string: "https://google.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func getFrom(from url: URL) {
            requestedURL = url
        }
    }
}
