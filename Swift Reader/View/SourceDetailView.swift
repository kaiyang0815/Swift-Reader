import SwiftSoup
//
//  SourceDetailView.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/17.
//
import SwiftUI

struct SourceDetailView: View {
    let source: Source

    @State private var selectedFilter: ClassOfSource = ClassOfSource(
        name: "", url: "")

    @State private var searchText: String = ""
    @ObservedObject private var viewModel: SourceDetailViewModel =
        SourceDetailViewModel()

    var body: some View {
        NavigationStack {
            List {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(viewModel.books) { book in
                        NavigationLink {
                            BookDetailView(book: book, source: source)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(book.name)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }

                    }
                }
            }
            .navigationTitle(source.name)
            .onChange(of: selectedFilter) { oldValue, newValue in
                if newValue != oldValue {
                    viewModel.clearBook()
                    viewModel.load(
                        url: URL(string: source.url + selectedFilter.url)!,
                        rule: source.bookInfoRule)
                }
            }
            .onAppear {
                selectedFilter = source.classOfSource.first!
                viewModel.load(
                    url: URL(string: source.url + selectedFilter.url)!,
                    rule: source.bookInfoRule)
            }
            .searchable(text: $searchText, prompt: "Search Book...")
            .toolbar {
                ToolbarItem {
                    Picker("Type", selection: $selectedFilter) {
                        ForEach(source.classOfSource, id: \.self) { item in
                            Text(item.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SourceDetailView(
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
            searchRule: ""
        )
    )
}
