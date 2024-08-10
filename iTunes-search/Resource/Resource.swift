//
//  Resource.swift
//  iTunes-search
//
//  Created by junehee on 8/9/24.
//

import UIKit

enum Color {
    static let white: UIColor = .white
    static let blue: UIColor = .systemBlue
    static let lightGray: UIColor = .systemGroupedBackground
    static let gray: UIColor = .gray
    static let black: UIColor = .black
}

enum SystemImage {
    static let tab: [UIImage] = [
        UIImage(systemName: "magnifyingglass")!,
        UIImage(systemName: "music.note.list")!
    ]
}

enum Font {
    static let bold14: UIFont = .systemFont(ofSize: 14, weight: .bold)
    static let bold18: UIFont = .systemFont(ofSize: 18, weight: .bold)
    static let light12: UIFont = .systemFont(ofSize: 12, weight: .light)
}
