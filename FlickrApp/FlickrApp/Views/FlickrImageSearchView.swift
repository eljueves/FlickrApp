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
    @State private var isSearching: Bool = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                ScrollView {
                    FlickrItemsGridView(search: flickrSearch)
                        .padding()
                }
                if isSearching {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3.0, anchor: .center)
                        .background(Color.clear.blur(radius: 10))
                }
            }
        }
        .searchable(text: $searchString)
        .onSubmit(of: .search, searchFlickr)
        .onChange(of: searchString, initial: true) {
            searchFlickr()
        }
    }
    
    func searchFlickr() {
        isSearching = true
        Task {
            defer {
                isSearching = false
            }
            guard let flickrSearch = await FlickrImageFetcher().searchImages(searchTerm: searchString) else {
                print("search returned nil")
                return
            }
            
            self.flickrSearch = flickrSearch
        }
    }
}

#Preview {
    FlickrImageSearchView()
}
