//
//  Search.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import Foundation

struct Search: Decodable {
    let resultCount: Int
    let results: [SearchResults]
}

struct SearchResults: Decodable {
    // let artistId: Int
    // let collectionId: Int
    // let trackId: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let artworkUrl100: String
}
