//
//  FlickrImagesGridView.swift
//  FlickrApp
//
//  Created by El Mero Mero on 1/31/25.
//

import SwiftUI

struct FlickrItemsGridView: View {
    private var search: FlickrSearch
    
    var body: some View {
        Grid {
            ForEach(Array(zip(search.items.indices, search.items)), id: \.0) { item in
                if let url = URL(string: item.1.media) {
                    AsyncImage(url: url)
                } else {
                    Text(LocalizedStringResource(stringLiteral: "Could not find image"))
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
