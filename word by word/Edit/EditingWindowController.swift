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
    
    init(_ song: Song) {
        super.init(window: nil)
        
        self.song = song
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
    
    @IBAction func cancel(_ sender: NSButton?) {
        //TODO: set search item self value to nil
        window!.close()
    }
    
    @IBAction func saveAndQuit(_ sender: NSButton) {
    }
    
    @IBAction func saveAndEditTiming(_ sender: NSButton) {
    }
    
    @IBAction func delete(_ sender: NSButton) {
    }
    
    @IBAction func onTitle(_ sender: NSTextField) {
        //if not all filled out (waiting on others)
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
