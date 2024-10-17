//
//  SourceDetailViewModel.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/17.
//
import SwiftUI
import WebKit
import SwiftSoup
import Combine

class SourceDetailViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false
    private var webView: WKWebView!
    private var bookRule: BookInfoRule = BookInfoRule()
    
    override init() {
        super.init()
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }
    
    // 加载网页
    func load(url: URL, rule: BookInfoRule) {
        DispatchQueue.main.async {
            self.isLoading = true
            self.bookRule = rule
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // 网页加载完成时
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 获取网页的HTML内容
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, error: Error?) in
            if let htmlString = html as? String {
                // 解析HTML内容
                self.parseHTML(htmlString, rule: self.bookRule)
            }
        }
    }
    
    func clearBook() {
        DispatchQueue.main.async {
            self.books.removeAll()
        }
    }
    
    // 使用SwiftSoup解析HTML
    private func parseHTML(_ html: String, rule: BookInfoRule) {
        do {
            let document = try SwiftSoup.parse(html)
            
            let divItems = try document.select(rule.itemsRule)
            for div in divItems {
                let name = try div.select(rule.nameRule).text()
                let url = try div.select(rule.urlRule).attr("href")
                let author = try div.select(rule.authorRule).text()
                let desc = try div.select(rule.introRule).text()
                
                let cover = try div.select(rule.coverRule).attr("src")
                
                let book = Book(name: name, author: author, desc: desc, cover: cover, url: url)
                DispatchQueue.main.async {
                    self.books.append(book)
                }
            }
            DispatchQueue.main.async {
                if !self.books.isEmpty {
                    self.isLoading = false
                }
            }
        } catch {
            print("解析错误: \(error)")
        }
    }
}
