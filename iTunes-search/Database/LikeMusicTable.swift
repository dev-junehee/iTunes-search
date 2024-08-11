//
//  LikeMusicTable.swift
//  iTunes-search
//
//  Created by junehee on 8/11/24.
//

import Foundation
import RealmSwift

class LikeMusic: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var artistName: String
    @Persisted var collectionName: String
    @Persisted var trackName: String
    @Persisted var artworkUrl100: String
    
    convenience init(music: SearchResults) {
        self.init()
        self.id = music.trackId
        self.artistName = music.artistName
        self.collectionName = music.collectionName
        self.trackName = music.trackName
        self.artworkUrl100 = music.artworkUrl100
    }
}
