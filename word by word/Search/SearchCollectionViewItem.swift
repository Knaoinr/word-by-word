//
//  SearchCollectionViewItem.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/28/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class SearchCollectionViewItem: NSCollectionViewItem {
    
    // MARK: - Objects
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var artistLabel: NSTextField!
    
    var song:Song?
    
    // MARK: - Methods
    
    init(_ song: Song) {
        super.init(nibName: "SearchCollectionViewItem", bundle: Bundle.main)
        
        self.song = song
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if song != nil {
            setupWithSong(song!)
        }
    }
    
    func setupWithSong(_ song: Song) {
        (view as! ColorView).changeGradientColor(start: song.topGradientComponents.toColor(), end: song.bottomGradientComponents.toColor())
        titleLabel.stringValue = song.title
        artistLabel.stringValue = "by"
        for artist in song.artists {
            artistLabel.stringValue += " " + artist + ","
        }
        let _ = artistLabel.stringValue.popLast()
        titleLabel.textColor = song.fontComponents.toColor()
        artistLabel.textColor = song.fontComponents.toColor()
    }
    
    @IBAction func onSettingsPress(_ sender: NSButton) {
    }
    
}
