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
    
    var song:Song!
    var editingWindowController:EditingWindowController?
    var viewSongWindowController:ViewSongWindowController?
    
    let doubleClick = NSClickGestureRecognizer()
    
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
        
        setupWithSong()
        
        //make sure to do this when editing window is closed (song is changed)
        editingWindowController = EditingWindowController(song: song, sender: self)
        
        //play on double click
        doubleClick.numberOfClicksRequired = 2
        doubleClick.delaysPrimaryMouseButtonEvents = false
        doubleClick.delaysSecondaryMouseButtonEvents = false
        doubleClick.delaysOtherMouseButtonEvents = false
        doubleClick.target = self
        doubleClick.action = #selector(onDoubleClick)
        view.addGestureRecognizer(doubleClick)
    }
    
    //sets up UI for song; can be recalled when song changed
    func setupWithSong() {
        (view as! ColorView).changeGradientColor(start: song.topGradientColor, end: song.bottomGradientColor)
        titleLabel.stringValue = song.title
        artistLabel.stringValue = "by"
        for artist in song.artists {
            artistLabel.stringValue += " " + artist + ","
        }
        let _ = artistLabel.stringValue.popLast()
        titleLabel.textColor = song.fontColor
        artistLabel.textColor = song.fontColor
    }
    
    @IBAction func onSettingsPress(_ sender: NSButton) {
        //if closed, recreate; else pull up already open window
        if editingWindowController == nil {
            editingWindowController = EditingWindowController(song: song, sender: self)
        }
        editingWindowController!.window?.makeKeyAndOrderFront(self)
    }
    
    @objc func onDoubleClick() {
        //open view song window
        viewSongWindowController = ViewSongWindowController(song)
        if AppDelegate.playWindow == nil {
            AppDelegate.playWindow = viewSongWindowController!.window
        } else {
            let frame = AppDelegate.playWindow!.frame
            AppDelegate.playWindow!.close()
            AppDelegate.playWindow = viewSongWindowController!.window
            AppDelegate.playWindow!.setFrame(frame, display: true)
        }
        AppDelegate.playWindow!.makeKeyAndOrderFront(self)
    }
    
}
