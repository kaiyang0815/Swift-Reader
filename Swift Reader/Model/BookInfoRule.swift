//
//  BookInfoRule.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/17.
//
import Foundation

struct BookInfoRule: Codable {
    var itemsRule: String
    var nameRule: String
    var authorRule: String
    var urlRule: String
    var introRule: String
    var coverRule: String
    
    init(
        itemsRule: String = "",
        nameRule: String = "",
        authorRule: String = "",
        urlRule: String = "",
        introRule: String = "",
        coverRule: String = ""
    ) {
        self.itemsRule = itemsRule
        self.nameRule = nameRule
        self.authorRule = authorRule
        self.urlRule = urlRule
        self.introRule = introRule
        self.coverRule = coverRule
    }
}
