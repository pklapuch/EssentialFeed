//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Pawel Klapuch on 7/25/22.
//

import Foundation

public struct FeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
}
