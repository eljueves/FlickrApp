//
//  FlickrImageFetcher.swift
//  FlickrApp
//
//  Created by El Mero Mero on 1/31/25.
//

import Foundation

class FlickrImageFetcher {
    private var currentPage = 1
    private var searchTerm: String = ""
    let baseURLFormat = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=%d"
    
    
    func searchImages(searchTerm: String) async -> FlickrSearch? {
        self.currentPage = 1
        self.searchTerm = searchTerm
        
        return await fetchImages()
    }
    
    func fetchImages() async -> FlickrSearch? {
        var urlString = String(format: baseURLFormat, self.currentPage)
        if self.searchTerm.count > 0 {
            urlString += "&tags=\(self.searchTerm)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Could not construct URL")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(FlickrSearch.self, from: data)
        } catch {
            print("\(error)")
        }
        
        
        return nil
    }
}
