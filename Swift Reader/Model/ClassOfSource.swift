//
//  ClassOfSource.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/16.
//

import Foundation

struct ClassOfSource: Hashable, Codable {
    var id: UUID
    var name: String
    var url: String

    init(id: UUID = UUID(), name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }
}
