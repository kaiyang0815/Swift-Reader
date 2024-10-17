//
//  BookDetailView.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/17.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    let source: Source
    @StateObject private var viewModel: BookDetailViewModel =
        BookDetailViewModel()
    @State private var searchChapterText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.chapters, id: \.self) { chapter in
                    Text(chapter.name)
                }
            }
            .navigationTitle(book.name)
            .searchable(text: $searchChapterText)
            .onAppear {
                viewModel.load(url: URL(string: processURL(inputURL: book.url, baseURL: source.url))!, rule: source.tocRule)
            }
        }
    }
    
    func processURL(inputURL: String, baseURL: String) -> String {
        if inputURL.hasPrefix("//") {
            // 如果以//开头，补全为https:
            return "https:" + inputURL
        } else if inputURL.hasPrefix("/") {
            // 如果以/开头，添加baseURL
            return baseURL + inputURL
        } else {
            // 否则返回原始链接
            return inputURL
        }
    }
}

#Preview {
    BookDetailView(
        book: Book(
            name: "异兽迷城",
            author: "彭湃",
            desc:
                "高阳是个孤儿，六岁穿越到“平行世界”，从此生活在一个温馨的五口之家。 十八岁那年，高阳偶然发现世界真相：这里根本不是平行世界，而是一个神秘领域，身边的亲人朋友全是可怕的“兽”！发现真相的高阳差点被杀，关键时刻获得系统【幸运】——活得越久就越强！ 一场羔羊与狼的厮杀游戏由此展开……",
            cover: "//bookcover.yuewen.com/qdbimg/349573/1036370336/150",
            url: "https://cn.ttkan.co/novel/chapters/yishoumicheng-pengpai"
        ),
        source: Source(
            order: 1,
            name: "起点读书",
            type: 0,
            group: 0,
            url: "https://www.qidian.com",
            classOfSource: [
                ClassOfSource(name: "全部", url: "/all/subCateId8/"),
                ClassOfSource(name: "东方玄幻", url: "/all/chanId21-subCateId8/"),
                ClassOfSource(name: "异世大陆", url: "/all/chanId21-subCateId73/"),
                ClassOfSource(name: "王朝争霸", url: "/all/chanId21-subCateId58/"),
                ClassOfSource(name: "高武世界", url: "/all/chanId21-subCateId78/"),
            ],
            searchURL: "/so/{{key}}.html,{'webView': true}",
            lastUpdateTime: "",
            bookInfoRule: BookInfoRule(
                itemsRule: "ul.all-img-list.cf li",
                nameRule: "div.book-mid-info > h2 > a",
                authorRule: "div.book-mid-info > p.author > a.name",
                urlRule: "div.book-mid-info > h2 > a",
                introRule: "div.book-mid-info > p.intro",
                coverRule: "div.book-img-box > a > img"
            ),
            bookContentRule: "",
            searchRule: "",
            tocRule: TOCRule(
                itemsRule: "div.full_chapters > div > a",
                nameRule: "a",
                urlRule: "a"
            )
        )
    )
}
