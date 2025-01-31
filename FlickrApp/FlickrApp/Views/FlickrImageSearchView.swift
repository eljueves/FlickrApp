//
//  ContentView.swift
//  FlickrApp
//
//  Created by El Mero Mero on 1/31/25.
//

import SwiftUI

struct FlickrImageSearchView: View {
    @State private var searchString = ""
    @State private var flickrSearch = FlickrSearch(items: [])
    
    var body: some View {
        NavigationStack {
            
            FlickrItemsGridView(search: flickrSearch)
                .navigationTitle("Search Flickr")
//                .navigationDestination(for: Image.self, destination: { image in
//                    image
//                })
                .searchable(text: $searchString)
                .task {
                    guard let flickrSearch = await FlickrImageFetcher().searchImages(searchTerm: searchString) else {
                        print("search returned nil")
                        return
                    }
                    
                    self.flickrSearch = flickrSearch
                }
        }
    }
}

#Preview {
    FlickrImageSearchView()
}
