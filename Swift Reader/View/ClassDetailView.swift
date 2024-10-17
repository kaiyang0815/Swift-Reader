//
//  ClassDetailView.swift
//  Swift Reader
//
//  Created by kaiyang on 2024/10/17.
//

import SwiftUI

struct ClassDetailView: View {
    @ObservedObject private var viewModel: SourceDetailViewModel =
        SourceDetailViewModel()

    let classOfSource: ClassOfSource

    var body: some View {
        List {
            ForEach(viewModel.books) { book in
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

#Preview {
    ClassDetailView(
        classOfSource: ClassOfSource(name: "玄幻", url: "/novel/class/xuanhuan"))
}
