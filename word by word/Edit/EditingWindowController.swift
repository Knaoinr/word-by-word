//
//  EditingWindowController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/29/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class EditingWindowController: NSWindowController, NSWindowDelegate {
    
    // MARK: - Objects
    
    var song:Song!
    var sender:SearchCollectionViewItem!
    var newSong:Song?
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var artistsTokenField: NSTokenField!
    
    @IBOutlet weak var topGradientColorWell: NSColorWell!
    @IBOutlet weak var bottomGradientColorWell: NSColorWell!
    @IBOutlet weak var fontColorWell: NSColorWell!
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var letter: NSTextField!
    @IBOutlet weak var alternateColorWell: NSColorWell!
    
    @IBOutlet weak var lyricsLabel: NSTextField!
    @IBOutlet weak var songLengthLabel: NSTextField!
    @IBOutlet weak var firstLyricLabel: NSTextField!
    @IBOutlet weak var lyricsTextView: NSTextView!
    @IBOutlet weak var songMinute: NSTextField!
    @IBOutlet weak var songSecond: NSTextField!
    @IBOutlet weak var firstMinute: NSTextField!
    @IBOutlet weak var firstSecond: NSTextField!
    
    @IBOutlet weak var deleteSongButton: NSButton!
    
    @IBOutlet weak var saveAndQuitButton: NSButton!
    
    
    // MARK: - Protocol
    
    override var windowNibName: NSNib.Name? {
        return "EditingWindowController"
    }
    
    init(song: Song, sender: SearchCollectionViewItem) {
        super.init(window: nil)
        
        self.song = song
        self.sender = sender
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        window!.delegate = self
        
        window!.title = "Editing \"" + song.title + "\""
        
        //Put current values in
        titleTextField.stringValue = song.title
        artistsTokenField.objectValue = song.artists
        topGradientColorWell.color = song.topGradientColor
        bottomGradientColorWell.color = song.bottomGradientColor
        fontColorWell.color = song.fontColor
        if song.alternateFontColor != nil {
            alternateColorWell.color = song.alternateFontColor!
        } else {
            alternateColorWell.color = song.fontColor
        }
        colorView.changeGradientColor(start: song.topGradientColor, end: song.bottomGradientColor)
        letter.textColor = song.fontColor
        lyricsTextView.string = convertToOneBigString(song.lyrics)
        songMinute.stringValue = "\(round(floor(song.songLength)/60))"
        songSecond.stringValue = "\(song.songLength.truncatingRemainder(dividingBy: 60))"
        firstMinute.stringValue = "\(round(floor(song.firstLyric)/60))"
        firstSecond.stringValue = "\(song.firstLyric.truncatingRemainder(dividingBy: 60))"
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        // use cancel method instead of closing
        cancel(nil)
        return false
    }
    
    // MARK: - Action response methods
    
    // Correctly exits window (does not save, but does not revert)
    @IBAction func cancel(_ sender: NSButton?) {
        //set search item self value to nil
        window!.close()
        self.sender.editingWindowController = nil
    }
    
    @IBAction func saveAndQuit(_ sender: NSButton) {
        //if can save, do save, then use cancel() to set self to nil
        if saveIfPossible() {
            cancel(nil)
        }
    }
    
    @IBAction func saveAndEditTiming(_ sender: NSButton) {
        //if can save, do save, then switch to timing VC
        if saveIfPossible() {
            window!.contentViewController = TimingViewController(newSong!)
        }
    }
    
    func saveIfPossible() -> Bool {
        //check to make sure everything vital is filled out
        if titleTextField.stringValue == "" || artistsTokenField.stringValue == "" || lyricsTextView.string == "" || songMinute.stringValue == "" || songSecond.stringValue == "" || firstMinute.stringValue == "" || firstSecond.stringValue == "" {
            return false
        }
        
        //copy song to some extent
        newSong = Song(title: song.title, artists: song.artists, lyrics: song.lyrics, songLength: song.songLength, firstLyric: song.firstLyric)
        newSong!.timing = song.timing
        
        //erase timing & save dangerous values if different (no allowance >:()
        if lyricsTextView.string != convertToOneBigString(song.lyrics) || songMinute.stringValue != "\(round(floor(song.songLength)/60))" || songSecond.stringValue != "\(song.songLength.truncatingRemainder(dividingBy: 60))" || firstMinute.stringValue != "\(round(floor(song.firstLyric)/60))" || firstSecond.stringValue != "\(song.firstLyric.truncatingRemainder(dividingBy: 60))" {
            //set values
            //1. lyrics
            let everyLineBreakIsN = lyricsTextView.string.replacingOccurrences(of: "\r", with: "\n")
            let lineArray = everyLineBreakIsN.split(separator: "\n")
            var lyricArray:[Array<String>] = []
            var z = 0
            for x in 0...lineArray.count-1 {
                if lineArray[x].split(separator: " ").count > 0 {
                    lyricArray.append([])
                    for y in 0...lineArray[x].split(separator: " ").count - 1 {
                        lyricArray[z].append(String(lineArray[x].split(separator: " ")[y]))
                    }
                    z += 1
                }
            }
            newSong!.lyrics = lyricArray
            
            //2. timing
            newSong!.songLength = CGFloat(60*songMinute.floatValue + songSecond.floatValue)
            newSong!.firstLyric = CGFloat(60*firstMinute.floatValue + firstSecond.floatValue)
            
            //erase timing
            newSong!.resetTimingSize()
        }
        
        //save safe values!
        newSong!.title = titleTextField.stringValue
        newSong!.artists = artistsTokenField.objectValue as! Array<String>
        newSong!.topGradientColor = topGradientColorWell.color
        newSong!.bottomGradientColor = bottomGradientColorWell.color
        newSong!.fontColor = fontColorWell.color
        newSong!.alternateFontColor = alternateColorWell.color
        
        //actually save
        //Save song
        var songBank = AppDelegate.songBank
        songBank[songBank.firstIndex(of: song)!] = newSong!
        AppDelegate.songBank = songBank
        
        //replace in collections
        let collectionBank = AppDelegate.collectionBank
        for collection in collectionBank {
            //if contained in collection, replace
            if collection.songs.contains(song) {
                collection.songs[collection.songs.firstIndex(of: song)!] = newSong!
            }
        }
        AppDelegate.collectionBank = collectionBank
        
        //refresh changes on cv item
        self.sender.song = newSong!
        self.sender.setupWithSong()
        
        return true
    }
    
    @IBAction func delete(_ sender: NSButton) {
        //TODO: delete
    }
    
    @IBAction func onTitle(_ sender: NSTextField) {
        //make sure filled out
        if sender.stringValue == "" {
            saveAndQuitButton.isEnabled = false
            window!.title = "Please insert a name."
        } else {
            saveAndQuitButton.isEnabled = true
            window!.title = "Editing \"" + sender.stringValue + "\""
        }
    }
    
    @IBAction func onTopGradientWell(_ sender: NSColorWell) {
        colorView.changeGradientColor(start: sender.color, end: colorView.endColor)
    }
    
    @IBAction func onBottomGradientWell(_ sender: NSColorWell) {
        colorView.changeGradientColor(start: colorView.startColor, end: sender.color)
    }
    
    @IBAction func onFontWell(_ sender: NSColorWell) {
        letter.textColor = sender.color
    }
    
    @IBAction func onDangerousLockChange(_ sender: NSButton) {
        //make light if on, dark if off
        if sender.state == .on {
            //enable
            lyricsLabel.textColor = .labelColor
            songLengthLabel.textColor = .labelColor
            firstLyricLabel.textColor = .labelColor
            
            lyricsTextView.textColor = .labelColor
            lyricsTextView.isEditable = true
            lyricsTextView.isSelectable = true
            
            songMinute.isEnabled = true
            songSecond.isEnabled = true
            firstMinute.isEnabled = true
            firstSecond.isEnabled = true
        } else {
            //disable
            lyricsLabel.textColor = .secondaryLabelColor
            songLengthLabel.textColor = .secondaryLabelColor
            firstLyricLabel.textColor = .secondaryLabelColor
            
            lyricsTextView.textColor = .secondaryLabelColor
            lyricsTextView.isEditable = false
            lyricsTextView.isSelectable = false
            
            songMinute.isEnabled = false
            songSecond.isEnabled = false
            firstMinute.isEnabled = false
            firstSecond.isEnabled = false
        }
    }
    
    
    // MARK: - Homemade methods
    
    func convertToOneBigString(_ array: [Array<String>]) -> String {
        var result = ""
        
        for x in 0...array.count-1 {
            for y in 0...array[x].count-1 {
                //for every word, add word + space if not last
                result += array[x][y]
                if y != array[x].count-1 {
                    result += " "
                }
            }
            //for every line, add newline if not last
            if x != array.count-1 {
                result += "\n"
            }
        }
        
        return result
    }
    
}
