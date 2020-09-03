//
//  Playlist.swift
//  ConsumirAPIs
//
//  Created by Eduardo Lopes de Carvalho on 03/09/20.
//  Copyright © 2020 Francisco Soares Neto. All rights reserved.
//

import Foundation

// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let items: [Item]
    let limit: Int
    let next: String
    let offset: Int
    let previous: JSONNull?
    let total: Int
}

// MARK: - Item
struct Item: Codable {
    let collaborative: Bool
    let itemDescription: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let primaryColor: JSONNull?
    let itemPublic: Bool
    let snapshotID: String
    let tracks: Tracks
    let type: ItemType
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case itemDescription = "description"
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case primaryColor = "primary_color"
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Image
struct Image: Codable {
    let height: Int?
    let url: String
    let width: Int?
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let type: OwnerType
    let uri: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

enum OwnerType: String, Codable {
    case user = "user"
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let total: Int
}

enum ItemType: String, Codable {
    case playlist = "playlist"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
