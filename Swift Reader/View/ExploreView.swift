//
//  ExploreView.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/16.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchSourceText: String = ""
    @State private var sources: [Source] = [
        Source(
            order: 0,
            name: "天天看小说",
            type: 0,
            group: 0,
            url: "https://cn.ttkan.co",
            classOfSource: [
                ClassOfSource(name: "排行", url: "/novel/rank"),
                ClassOfSource(name: "连载", url: "/novel/class/lianzai"),
                ClassOfSource(name: "随选", url: "/novel/class/suixuan"),
                ClassOfSource(name: "玄幻", url: "/novel/class/xuanhuan"),
                ClassOfSource(name: "都市", url: "/novel/class/dushi"),
                ClassOfSource(name: "仙侠", url: "/novel/class/xianxia"),
                ClassOfSource(name: "言情", url: "/novel/class/gudaiyanqing"),
                ClassOfSource(
                    name: "穿越", url: "/novel/class/chuanyuechongsheng"),
                ClassOfSource(name: "游戏", url: "/novel/class/youxi"),
                ClassOfSource(name: "科幻", url: "/novel/class/kehuan"),
                ClassOfSource(name: "悬疑", url: "/novel/class/xuanyi"),
                ClassOfSource(name: "灵异", url: "/novel/class/lingyi"),
                ClassOfSource(name: "历史", url: "/novel/class/lishi"),
                ClassOfSource(name: "青春", url: "/novel/class/qingchun"),
                ClassOfSource(name: "军事", url: "/novel/class/junshi"),
                ClassOfSource(name: "竞技", url: "/novel/class/jingji"),
                ClassOfSource(name: "现言", url: "/novel/class/yanqing"),
                ClassOfSource(name: "其它", url: "/novel/class/qita"),
            ],
            searchURL: "/novel/search?q={{key}}",
            lastUpdateTime: "",
            bookInfoRule: BookInfoRule(
                itemsRule: "div.pure-g > div.novel_cell",
                nameRule: "ul > li:nth-child(1) > a > h3",
                authorRule: "ul > li:nth-child(2)",
                urlRule: "ul > li:nth-child(1) > a",
                introRule: "ul > li:nth-child(3)",
                coverRule: "div:nth-child(2) > a > amp-img > img"
            ),
            bookContentRule: "",
            searchRule: "",
            tocRule: TOCRule(
                itemsRule: "div.full_chapters > div > a",
                nameRule: "a",
                urlRule: "a"
            )
        ),
        Source(
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
                ClassOfSource(name: "现代魔法", url: "/all/chanId1-subCateId73/"),
                ClassOfSource(name: "剑与魔法", url: "/all/chanId1-subCateId62/"),
                ClassOfSource(name: "史诗奇幻", url: "/all/chanId1-subCateId201/"),
                ClassOfSource(name: "神秘幻想", url: "/all/chanId1-subCateId202/"),
                ClassOfSource(
                    name: "历史神话", url: "/all/chanId1-subCateId20092/"),
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
                itemsRule: "#allCatalog > div > ul > li.chapter-item",
                nameRule: "a",
                urlRule: "a"
            )
        ),
    ]

    @ViewBuilder
    func NavLabel(_ source: Source) -> some View {
        Group {
            if source.enabled {
                NavigationLink {
                    SourceDetailView(source: source)
                } label: {
                    Text(source.name)
                }
            } else {
                Text(source.name)
            }
        }
        .swipeActions {
            Button {
                withAnimation {
                    source.enabled.toggle()
                }
            } label: {
                source.enabled ? Text("Disable") : Text("Enable")
            }
            .tint(source.enabled ? .red : .green)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Enabled") {
                    ForEach(
                        sources.filter {
                            $0.enabled
                        }, id: \.self
                    ) { source in
                        NavLabel(source)
                    }
                }
                Section("Unabled") {
                    ForEach(
                        sources.filter {
                            !$0.enabled
                        }, id: \.self
                    ) { source in
                        NavLabel(source)
                    }
                }
            }
            .navigationTitle("Explore")
            .searchable(text: $searchSourceText, prompt: "Search source...")
        }
    }
}

#Preview {
    ExploreView()
}
