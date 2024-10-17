//
//  BookDetailViewModel.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/17.
//

import SwiftUI
import WebKit
import SwiftSoup
import Combine

struct Chapter: Codable, Hashable {
    var id: UUID
    var name: String
    var url: String
    
    init(
        id: UUID = UUID(),
        name: String,
        url: String
    ) {
        self.id = id
        self.name = name
        self.url = url
    }
}

class BookDetailViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var chapters: [Chapter] = []
    @Published var isLoading: Bool = false
    private var webView: WKWebView!
    private var chapterRule: TOCRule = TOCRule()
    
    override init() {
        super.init()
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }
    
    // 加载网页
    func load(url: URL, rule: TOCRule) {
        DispatchQueue.main.async {
            self.isLoading = true
            self.chapterRule = rule
        }
        print(url)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // 网页加载完成时
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 获取网页的HTML内容
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, error: Error?) in
            if let htmlString = html as? String {
                // 解析HTML内容
                self.parseHTML(htmlString, rule: self.chapterRule)
            }
        }
    }
    
    func clearBook() {
        DispatchQueue.main.async {
            self.chapters.removeAll()
        }
    }
    
    // 使用SwiftSoup解析HTML
    private func parseHTML(_ html: String, rule: TOCRule) {
        do {
            let document = try SwiftSoup.parse(html)
            print(document)
            let divItems = try document.select(rule.itemsRule)
            for div in divItems {
                let name = try div.select(rule.nameRule).text()
                let url = try div.select(rule.urlRule).attr("href")
                let chapter = Chapter(name: name, url: url)
                
                print(chapter)
                DispatchQueue.main.async {
                    self.chapters.append(chapter)
                }
            }
        } catch {
            print("解析错误: \(error)")
        }
        if !self.chapters.isEmpty {
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
