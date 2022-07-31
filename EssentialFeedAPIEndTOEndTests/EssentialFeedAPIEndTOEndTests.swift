//
//  EssentialFeedAPIEndTOEndTests.swift
//  EssentialFeedAPIEndTOEndTests
//
//  Created by Pawel Klapuch on 7/30/22.
//

import XCTest
import EssentialFeed

class EssentialFeedAPIEndTOEndTests: XCTestCase {
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        switch getFeedResult() {
        case let .success(items):
            XCTAssertEqual(items.count, 8, "Expected 8 items in the test account feed")
        case let .failure(error):
            XCTFail("\(error)")
        default:
            XCTFail("Expected result, got nothing")
        }
    }
    
    func getFeedResult(file: StaticString = #filePath, line: UInt = #line) -> LoadFeedResult? {
        let testServerURL = URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
        let session = URLSession(configuration: .ephemeral)
        let client = URLSessionHTTPClient(session: session)
        let loader = RemoteFeedLoader(url: testServerURL, client: client)
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        
        let exp = expectation(description: "Wait for load completion")
        var receivedResult: LoadFeedResult?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 15)
        return receivedResult
    }
}
