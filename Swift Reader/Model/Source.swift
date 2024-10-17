//
//  Source.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/16.
//

import Foundation
import SwiftData

@Model
final class Source {
    var id: UUID
    var order: Int
    var name: String
    var type: Int
    var group: Int
    var url: String

    var enabled: Bool
    var enabledExplore: Bool

    var classOfSource: [ClassOfSource]
    var searchURL: String
    var lastUpdateTime: String

    var bookInfoRule: BookInfoRule
    var bookContentRule: String
    var searchRule: String
    var tocRule: TOCRule

    init(
        id: UUID = UUID(),
        order: Int,
        name: String,
        type: Int,
        group: Int,
        url: String,
        enabled: Bool = true,
        enabledExplore: Bool = true,
        classOfSource: [ClassOfSource] = [],
        searchURL: String,
        lastUpdateTime: String,
        bookInfoRule: BookInfoRule,
        bookContentRule: String,
        searchRule: String,
        tocRule: TOCRule = TOCRule()
    ) {
        self.id = id
        self.order = order
        self.name = name
        self.type = type
        self.group = group
        self.url = url
        self.enabled = enabled
        self.enabledExplore = enabledExplore
        self.classOfSource = classOfSource
        self.searchURL = searchURL
        self.lastUpdateTime = lastUpdateTime
        self.bookInfoRule = bookInfoRule
        self.bookContentRule = bookContentRule
        self.searchRule = searchRule
        self.tocRule = tocRule
    }
}
