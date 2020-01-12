//
//  ViewSongWindowController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 1/1/20.
//  Copyright © 2020 Knaoinr. All rights reserved.
//

import Cocoa

class ViewSongWindowController: NSWindowController, NSWindowDelegate {
    
    // MARK: Objects
    
    var song: Song!
    var oneBelowIndex:[Int]?
    
    @IBOutlet weak var colorView: ColorView!
    @IBOutlet weak var timeSlider: NSSlider!
    @IBOutlet weak var startLabel: NSTextField!
    @IBOutlet weak var endLabel: NSTextField!
    @IBOutlet weak var playPauseButton: NSButton!
    @IBOutlet weak var word: NSTextField!
    
    var timer = Timer()
    
    // MARK: - Protocol
    
    override var windowNibName: NSNib.Name? {
        return "ViewSongWindowController"
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
        
        //setup colors
        colorView.changeGradientColor(start: song.topGradientColor, end: song.bottomGradientColor)
        word.textColor = song.fontColor
        startLabel.textColor = song.fontColor
        endLabel.textColor = song.fontColor
        
        //setup text & place at start
        word.stringValue = song.lyrics[0][0]
        oneBelowIndex = getNextWordIndex(0, 0)
        timeSlider.doubleValue = Double(song.firstLyric)
        startLabel.stringValue = "\(Double(round(10*song.firstLyric)/10))"
        
        endLabel.stringValue = "\(Double(round(10*song.songLength)/10))"
        timeSlider.maxValue = Double(song.songLength)
        
        //delegate!
        window!.delegate = self
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        AppDelegate.playWindow = nil
        return true
    }
    
    // MARK: - Action response methods
    
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
    
    //On each 0.05s of timer on
    @objc func updatePlay() {
        //change slider
        timeSlider.doubleValue += 0.05
        startLabel.stringValue = "\(Double(round(10*timeSlider.doubleValue)/10))"
        
        //if end
        if timeSlider.doubleValue >= Double(song!.songLength) {
            //if in queue
            if AppDelegate.isPlayingQueue {
                //if has remaining songs
                if !(AppDelegate.mainWindow!.windowController as! HomeWindowController).sideBarDataAndDelegate.queue.isEmpty {
                    //open view song window
                    AppDelegate.playWindowController = ViewSongWindowController((AppDelegate.mainWindow!.windowController as! HomeWindowController).sideBarDataAndDelegate.queue[0])
                    (AppDelegate.mainWindow!.windowController as! HomeWindowController).sideBarDataAndDelegate.queue.remove(at: 0)
                    let frame = AppDelegate.playWindow!.frame
                    timer.invalidate()
                    AppDelegate.playWindow!.close()
                    AppDelegate.playWindow = AppDelegate.playWindowController!.window
                    AppDelegate.playWindow!.setFrame(frame, display: true)
                    AppDelegate.playWindow!.makeKeyAndOrderFront(self)
                    return
                }
            } else { //playing by hand -> go back to start
                onPausePlay(playPauseButton)
                timeSlider.doubleValue = timeSlider.maxValue
                startLabel.stringValue = "\(Double(round(10*song.songLength)/10))"
            }
        }
        
        //automatically go down at the time
        if oneBelowIndex != nil {
            if song.timing[oneBelowIndex![0]][oneBelowIndex![1]] - CGFloat(timeSlider.doubleValue) < 0.025 {
                //set right color
                if word.stringValue == song.lyrics[oneBelowIndex![0]][oneBelowIndex![1]] && word.textColor == song.fontColor {
                    word.textColor = song.alternateFontColor
                } else {
                    word.textColor = song.fontColor
                }
                //move up
                word.stringValue = song.lyrics[oneBelowIndex![0]][oneBelowIndex![1]]
                oneBelowIndex = getNextWordIndex(oneBelowIndex![0], oneBelowIndex![1])
            }
        }
    }
    
    @IBAction func onInchForward(_ sender: NSButton) {
        //change slider
        timeSlider.doubleValue += 0.05
        startLabel.stringValue = "\(Double(round(10*timeSlider.doubleValue)/10))"
    }
    
    @IBAction func onInchBackward(_ sender: NSButton) {
        //change slider
        timeSlider.doubleValue -= 0.05
        startLabel.stringValue = "\(Double(round(10*timeSlider.doubleValue)/10))"
    }
    
    @IBAction func onSlide(_ sender: NSSlider) {
        //don't stop timer
        
        startLabel.stringValue = "\(Double(round(10*sender.doubleValue)/10))"
        
        //put correct lyrics in place
        let rightIndex = getWordAtTime(CGFloat(sender.doubleValue), in: song.timing)
        word.stringValue = song.lyrics[rightIndex[0]][rightIndex[1]]
        oneBelowIndex = getNextWordIndex(rightIndex[0], rightIndex[1])
        word.textColor = song.fontColor
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
    
    func getWordAtTime(_ time: CGFloat, in timingSystem: [Array<CGFloat>]) -> [Int] {
        if time <= song.firstLyric {
            return [0, 0]
        }
        
        //loop through starting at end
        var index = [timingSystem.count-1, timingSystem[timingSystem.count-1].count-1]
        while(timingSystem[index[0]][index[1]] >= time) {
            index = getLastWordIndex(index[0], index[1])!
        }
        return index
    }
    
}
