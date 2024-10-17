//
//  TOCRule.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/18.
//

import Foundation

struct TOCRule: Codable {
    var itemsRule: String
    var nameRule: String
    var urlRule: String
    
    init(itemsRule: String = "", nameRule: String = "", urlRule: String = "") {
        self.itemsRule = itemsRule
        self.nameRule = nameRule
        self.urlRule = urlRule
    }
}
