//
//  Model.swift
//  Noir
//
//  Created by Vitor Costa on 10/11/24.
//

import Foundation

enum Orientation {
    case horizontal
    case vertical
}

struct Word {
    var name: String
    var wasFound: Bool
    var initPosition: [Int]
    var lastPosition: [Int]
    var orientation: Orientation
}

enum WordCountErrors: Error {
    case isEmpty
}

extension String {
    /// Checks if two strings are equal, disregarding accentuation differences.
    /// - Parameter other: The other string to compare.
    /// - Returns: `true` if the strings are considered equal, ignoring accentuation; otherwise, `false`.
    func isEqualIgnoringAccents(_ other: String) -> Bool {
        return self.folding(options: .diacriticInsensitive, locale: .current) == other.folding(options: .diacriticInsensitive, locale: .current)
    }
}

