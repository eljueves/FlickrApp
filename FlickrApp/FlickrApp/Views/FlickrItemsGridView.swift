//
//  FlickrImagesGridView.swift
//  FlickrApp
//
//  Created by El Mero Mero on 1/31/25.
//

import SwiftUI

struct FlickrImagesDetailView: View {
    let item: FlickrSearchItem
    
    var body: some View {
        VStack {
            FlickrThumbnailView(item: item)
            Text(item.title)
            Text(item.description)
            Text(item.author)
        }
    }

}

struct FlickrThumbnailView: View {
    let item: FlickrSearchItem
    
    var body: some View {
        if let url = URL(string: item.media) {
            VStack {
                AsyncImage(url: url)
                    .frame(width: 150)
                    .scaledToFit()
            }
        } else {
            Text(LocalizedStringResource(stringLiteral: "Could not find image"))
        }
    }
}

struct FlickrItemsGridView: View {
    private var search: FlickrSearch
    @State private var shouldPresentDetail: Bool = false
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 150))]) {
            ForEach(Array(zip(search.items.indices, search.items)), id: \.0) { item in
                FlickrThumbnailView(item: item.1)
                    .navigationDestination(isPresented: $shouldPresentDetail) {
                        FlickrImagesDetailView(item: item.1)
                    }
            }
        }
    }
    
    init(search: FlickrSearch) {
        self.search = search
    }
}



#Preview {
    FlickrItemsGridView(search: FlickrSearch(items: []))
}
