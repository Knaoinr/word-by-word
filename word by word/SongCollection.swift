//
//  SongCollection.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/26/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class SongCollection : Codable {
        
    var title = ""
    var isOrdered = true
    var songs:[Song] = []
    //TODO: var image - make it codable
    
    init(title:String, isOrdered:Bool, songs:[Song]) {
        self.title = title
        self.isOrdered = isOrdered
        self.songs = songs
    }
}
