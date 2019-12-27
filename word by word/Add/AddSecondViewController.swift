//
//  AddSecondViewController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/26/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class AddSecondViewController: NSViewController {
    
    // MARK: - Objects
    
    var songTitle:String = ""
    var songArtists:[String] = []
    var lyrics:[Array<String>] = []
    
    var backView:NSView?
    
    @IBOutlet weak var doneButton: NSButton!
    
    @IBOutlet weak var firstCombo: NSComboBox!
    @IBOutlet weak var secondCombo: NSComboBox!
    @IBOutlet weak var thirdCombo: NSComboBox!

    @IBOutlet weak var firstOrdered: NSButton!
    @IBOutlet weak var secondOrdered: NSButton!
    @IBOutlet weak var thirdOrdered: NSButton!
    
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var letter: NSTextField!
    
    @IBOutlet weak var songMinute: NSTextField!
    @IBOutlet weak var songSecond: NSTextField!
    @IBOutlet weak var firstMinute: NSTextField!
    @IBOutlet weak var firstSecond: NSTextField!
    
    var titles:[String] = []
    
    // MARK: - Protocol
    
    init(songTitle:String, songArtists:[String], songLyrics:Array<Array<String>>, backView:NSView?) {
        super.init(nibName: "AddSecondViewController", bundle: Bundle.main)
        
        self.songTitle = songTitle
        self.songArtists = songArtists
        self.lyrics = songLyrics
        
        self.backView = backView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //if there are already collections made
        if !UserDefaults.standard.array(forKey: "collectionBank")!.isEmpty {
            //get titles
            for element in UserDefaults.standard.array(forKey: "collectionBank")! {
                titles.append((element as! SongCollection).title)
            }
            firstCombo.addItems(withObjectValues: titles)
            secondCombo.addItems(withObjectValues: titles)
            thirdCombo.addItems(withObjectValues: titles)
        }
    }
    
    // MARK: - Action response methods
    
    // Back/done buttons
    
    @IBAction func back(_ sender: NSButton) {
        view = backView!
    }
    
    @IBAction func done(_ sender: NSButton) {
        print("done")
    }
    
    // Combo boxes
    
    @IBAction func onFirstComboChoice(_ sender: NSComboBox) {
        //if already exists, hide; or if no string
        if titles.contains(sender.stringValue) || sender.stringValue == "" {
            firstOrdered.isHidden = true
            firstOrdered.state = .off
        } else { //reveal
            firstOrdered.isHidden = false
        }
    }
    
    @IBAction func onSecondComboChoice(_ sender: NSComboBox) {
        //if already exists, hide; or if no string
        if titles.contains(sender.stringValue) || sender.stringValue == "" {
            secondOrdered.isHidden = true
            secondOrdered.state = .off
        } else { //reveal
            secondOrdered.isHidden = false
        }
    }
    
    @IBAction func onThirdComboChoice(_ sender: NSComboBox) {
        //if already exists, hide; or if no string
        if titles.contains(sender.stringValue) || sender.stringValue == "" {
            thirdOrdered.isHidden = true
            thirdOrdered.state = .off
        } else { //reveal
            thirdOrdered.isHidden = false
        }
    }
    
    // Color wells
    
    @IBAction func onTopGradientWell(_ sender: NSColorWell) {
        colorView.changeGradientColor(start: sender.color, end: colorView.endColor)
    }
    
    @IBAction func onBottomGradientWell(_ sender: NSColorWell) {
        colorView.changeGradientColor(start: colorView.startColor, end: sender.color)
    }
    
    @IBAction func onFontWell(_ sender: NSColorWell) {
        letter.textColor = sender.color
    }
    
    // Timing
    
    @IBAction func onSongMinute(_ sender: NSTextField) { checkForGoodTimes() }
    @IBAction func onSongSecond(_ sender: NSTextField) { checkForGoodTimes() }
    @IBAction func onFirstMinute(_ sender: NSTextField) { checkForGoodTimes() }
    @IBAction func onFirstSecond(_ sender: NSTextField) { checkForGoodTimes() }
    
    func checkForGoodTimes() {
        //if all timing is filled out
        if songMinute.stringValue != "" && songSecond.stringValue != "" && firstMinute.stringValue != "" && firstSecond.stringValue != "" {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    
}
