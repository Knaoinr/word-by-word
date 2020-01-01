//
//  TimingViewController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/26/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class TimingViewController: NSViewController {
    
    // MARK: - Objects
    
    var song:Song!
    var newTiming:[Array<CGFloat>] = []
    var justEditedTiming:[Array<CGFloat>] = []
    var oneBelowIndex:[Int]?
    var twoBelowIndex:[Int]?
    
    @IBOutlet weak var startLabel: NSTextField!
    @IBOutlet weak var endLabel: NSTextField!
    @IBOutlet weak var timeSlider: NSSlider!
    
    @IBOutlet weak var playPauseButton: NSButton!
    
    @IBOutlet weak var twoAboveLabel: NSTextField!
    @IBOutlet weak var oneAboveLabel: NSTextField!
    @IBOutlet weak var mainLabel: NSTextField!
    @IBOutlet weak var oneBelowLabel: NSTextField!
    @IBOutlet weak var twoBelowLabel: NSTextField!
    
    var timer = Timer()
    
    // MARK: - Initialization
    
    init(_ song: Song) {
        super.init(nibName: "TimingViewController", bundle: Bundle.main)
        
        self.song = song
        self.newTiming = song.timing
        self.justEditedTiming = song.timing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        //setup colors
        (view as! ColorView).changeGradientColor(start: song.topGradientColor, end: song.bottomGradientColor)
        twoAboveLabel.textColor = song.fontColor
        oneAboveLabel.textColor = song.fontColor
        mainLabel.textColor = song.fontColor
        oneBelowLabel.textColor = song.fontColor
        twoBelowLabel.textColor = song.fontColor
        
        startLabel.textColor = song.fontColor
        endLabel.textColor = song.fontColor
        
        //place text in labels
        mainLabel.stringValue = song.lyrics[0][0]
        if getNextWordIndex(0, 0) != nil {
            oneBelowIndex = getNextWordIndex(0, 0)!
            oneBelowLabel.stringValue = song.lyrics[oneBelowIndex![0]][oneBelowIndex![1]]
            
            if getNextWordIndex(oneBelowIndex![0], oneBelowIndex![1]) != nil {
                twoBelowIndex = getNextWordIndex(oneBelowIndex![0], oneBelowIndex![1])!
                twoBelowLabel.stringValue = song!.lyrics[twoBelowIndex![0]][twoBelowIndex![1]]
            } else {
                twoBelowIndex = nil
                twoBelowLabel.stringValue = ""
            }
            
        } else {
            oneBelowIndex = nil
            oneBelowLabel.stringValue = ""
        }
        
        //starting point
        timeSlider.doubleValue = Double(song.firstLyric)
        startLabel.stringValue = "\(Double(round(10*song.firstLyric)/10))"
        
        endLabel.stringValue = "\(Double(round(10*song.songLength)/10))"
        timeSlider.maxValue = Double(song.songLength)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if acceptsFirstResponder {
            view.window!.makeFirstResponder(self)
        }
    }
    
    // MARK: - Action response methods
    
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 125 {
            onDownArrow()
        } else {
            super.keyDown(with: event)
        }
    }
    
    //Restart/done buttons
    
    @IBAction func restart(_ sender: NSButton) {
    }
    
    @IBAction func done(_ sender: NSButton) {
    }
    
    //Playback controls
    
    @IBAction func onPausePlay(_ sender: NSButton) {
        //if paused, play
        if playPauseButton.image!.name() == NSImage.touchBarPlayTemplateName {
            playPauseButton.image = NSImage(named: NSImage.touchBarPauseTemplateName)
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updatePlay), userInfo: nil, repeats: true)
        } else { //else, stop
            playPauseButton.image = NSImage(named: NSImage.touchBarPlayTemplateName)
            timer.invalidate()
        }
    }
    
    @IBAction func onDiscardChanges(_ sender: NSButton) {
    }
    
    @IBAction func onSaveChanges(_ sender: NSButton) {
    }

    @IBAction func onSlide(_ sender: NSSlider) {
        //stop timer
        playPauseButton.image = NSImage(named: NSImage.touchBarPlayTemplateName)
        timer.invalidate()
        
        startLabel.stringValue = "\(Double(round(10*sender.doubleValue)/10))"
        
        //put correct lyrics in place
        let mainIndex = getWordAtTime(CGFloat(sender.doubleValue))
        mainLabel.stringValue = song.lyrics[mainIndex[0]][mainIndex[1]]
        if let nextIndex = getNextWordIndex(mainIndex[0], mainIndex[1]) {
            oneBelowIndex = nextIndex
            oneBelowLabel.stringValue = song.lyrics[nextIndex[0]][nextIndex[1]]
            
            if let evenNextIndex = getNextWordIndex(nextIndex[0], nextIndex[1]) {
                twoBelowIndex = evenNextIndex
                twoBelowLabel.stringValue = song.lyrics[evenNextIndex[0]][evenNextIndex[1]]
            } else {
                twoBelowIndex = nil
                twoBelowLabel.stringValue = ""
            }
        } else {
            oneBelowIndex = nil
            twoBelowIndex = nil
            oneBelowLabel.stringValue = ""
            twoBelowLabel.stringValue = ""
        }
        if let nextIndex = getLastWordIndex(mainIndex[0], mainIndex[1]) {
            oneAboveLabel.stringValue = song.lyrics[nextIndex[0]][nextIndex[1]]
            
            if let evenNextIndex = getLastWordIndex(nextIndex[0], nextIndex[1]) {
                twoAboveLabel.stringValue = song.lyrics[evenNextIndex[0]][evenNextIndex[1]]
            } else {
                twoAboveLabel.stringValue = ""
            }
        } else {
            oneAboveLabel.stringValue = ""
            twoAboveLabel.stringValue = ""
        }
    }
    
    @IBAction func onEditViewChoice(_ sender: NSSegmentedControl) {
    }
    
    //Timing + down arrow
    
    //On each 0.05s of timer on
    @objc func updatePlay() {
        //change slider
        timeSlider.doubleValue += 0.05
        startLabel.stringValue = "\(Double(round(10*timeSlider.doubleValue)/10))"
        
        //if end
        if timeSlider.doubleValue >= Double(song!.songLength) {
            onPausePlay(playPauseButton)
            timeSlider.doubleValue = timeSlider.maxValue
            startLabel.stringValue = "\(Double(round(10*song.songLength)/10))"
        }
    }
    
    func onDownArrow() {
        if oneBelowIndex != nil {
            //save timing for one down
            justEditedTiming[oneBelowIndex![0]][oneBelowIndex![1]] = CGFloat(timeSlider.floatValue)
            
            //move everything up
            twoAboveLabel.stringValue = oneAboveLabel.stringValue
            oneAboveLabel.stringValue = mainLabel.stringValue
            mainLabel.stringValue = oneBelowLabel.stringValue
            oneBelowLabel.stringValue = twoBelowLabel.stringValue
            oneBelowIndex = twoBelowIndex
            if twoBelowIndex != nil {
                if getNextWordIndex(twoBelowIndex![0], twoBelowIndex![1]) != nil {
                    twoBelowIndex = getNextWordIndex(twoBelowIndex![0], twoBelowIndex![1])!
                    twoBelowLabel.stringValue = song.lyrics[twoBelowIndex![0]][twoBelowIndex![1]]
                } else {
                    twoBelowIndex = nil
                    twoBelowLabel.stringValue = ""
                }
            }
        }
    }
    
    // MARK: - Homemade methods
    
    //Find next lyric from index
    func getNextWordIndex(_ lastX: Int, _ lastY: Int) -> [Int]? {
        if song.lyrics[lastX].count-1 > lastY { //if there are more in this row
            return [lastX, lastY+1]
        } else if song.lyrics.count-1 > lastX { //if there are more in next row
            return [lastX+1, 0]
        } else {
            return nil
        }
    }
    
    func getLastWordIndex(_ lastX: Int, _ lastY: Int) -> [Int]? {
        if lastY > 0 { //if there are more in this row
            return [lastX, lastY-1]
        } else if lastX > 0 { //if there are more in last row
            return [lastX-1, song.lyrics[lastX-1].count-1]
        } else {
            return nil
        }
    }
    
    func getWordAtTime(_ time: CGFloat) -> [Int] {
        if time <= song.firstLyric {
            return [0, 0]
        }
        
        //loop through starting at end
        var index = [newTiming.count-1, newTiming[newTiming.count-1].count-1]
        while(newTiming[index[0]][index[1]] >= time) {
            index = getLastWordIndex(index[0], index[1])!
        }
        return index
    }

}
