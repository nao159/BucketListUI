//
//  Result.swift
//  BucketListUI
//
//  Created by Максим Нуждин on 17.07.2021.
//

import Foundation

struct Result: Codable {
    
    let query: Query
}

struct Query: Codable {
    
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title.lowercased() < rhs.title.lowercased()
    }
    
    let padeid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}
