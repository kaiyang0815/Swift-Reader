//
//  Book.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/16.
//

import Foundation

struct Book: Identifiable {
    var id: UUID
    var name: String
    var author: String
    var desc: String
    var cover: String
    var url: String

    init(
        id: UUID = UUID(),
        name: String,
        author: String,
        desc: String,
        cover: String,
        url: String
    ) {
        self.id = id
        self.name = name
        self.author = author
        self.desc = desc
        self.cover = cover
        self.url = url
    }
}
