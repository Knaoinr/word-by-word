//
//  SideBarCollectionViewItem.swift
//  word by word
//
//  Created by Kiera O'Flynn on 1/5/20.
//  Copyright © 2020 Knaoinr. All rights reserved.
//

import Cocoa

class SideBarCollectionViewItem: NSCollectionViewItem {
    
    var song: Song!
    @IBOutlet weak var label: NSTextField!
    
    init(_ song: Song) {
        super.init(nibName: "SideBarCollectionViewItem", bundle: Bundle.main)
        
        self.song = song
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        label.stringValue = song.title
        view.layer?.borderWidth = 1
    }
    
}
