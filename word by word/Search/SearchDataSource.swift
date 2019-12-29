//
//  SearchDataSource.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/27/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class SearchDataSource : NSObject, NSCollectionViewDataSource {
    
    var searchResults:[Song] = []
    
    // MARK: - Protocol
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        return SearchCollectionViewItem(searchResults[indexPath.item])
    }
    
    // MARK: - Homemade methods
    
    // Use new search string to generate search results
    func changeSearch(_ searchString: String) {
        
        if searchString == "" {
            searchResults = AppDelegate.songBank
            return
        }
        
        searchResults = []
        
        for song in AppDelegate.songBank {
            if song.title.contains(searchString) {
                searchResults.append(song)
            } else if song.artists.contains(searchString) {
                searchResults.append(song)
            } else {
                for artist in song.artists {
                    if artist.contains(searchString) && !searchResults.contains(song) {
                        searchResults.append(song)
                    }
                }
                
                for line in song.lyrics {
                    if line.contains(searchString) && !searchResults.contains(song) {
                        searchResults.append(song)
                    }
                }
            }
        }
    }
    
}
