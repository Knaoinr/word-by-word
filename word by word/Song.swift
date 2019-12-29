//
//  Song.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/26/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class Song : Equatable, Codable {
    
    // MARK: - Variables
    
    var title = ""
    var artists:[String] = []
    var lyrics:[Array<String>] = []
    
    var timing:[Array<CGFloat>] = []
    var songLength:CGFloat = 0
    var firstLyric:CGFloat = 0
    
    private var topGradientComponents:[CGFloat] = [0,0,0,0]
    private var bottomGradientComponents:[CGFloat] = [0,0,0,0]
    private var fontComponents:[CGFloat] = [0,0,0,0]
    
    // MARK: - Methods
    
    init(title:String, artists:[String], lyrics:[Array<String>], songLength:CGFloat, firstLyric:CGFloat) {
        self.title = title
        self.artists = artists
        self.lyrics = lyrics
        self.songLength = songLength
        self.firstLyric = firstLyric
        
        resetTimingSize()
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        if lhs.title == rhs.title && lhs.artists == rhs.artists {
            return true
        } else {
            return false
        }
    }
    
    func setColors(topGradientColor:NSColor, bottomGradientColor:NSColor, fontColor:NSColor) {
        self.topGradientColor = topGradientColor
        self.bottomGradientColor = bottomGradientColor
        self.fontColor = fontColor
    }
    
    func resetTimingSize() {
        timing = []
        for index in 0...lyrics.count-1 {
            timing.append([])
            for _ in lyrics[index] {
                timing[index].append(songLength)
            }
        }
        timing[0][0] = firstLyric
    }
    
    // MARK: - Changing to/from colors
    
    var topGradientColor: NSColor {
        get {
            return NSColor(calibratedRed: topGradientComponents[0], green: topGradientComponents[1], blue: topGradientComponents[2], alpha: topGradientComponents[3])
        }
        set (settingColor) {
            let color = settingColor.usingColorSpace(.deviceRGB)
            topGradientComponents = [color!.redComponent, color!.greenComponent, color!.blueComponent, color!.alphaComponent]
        }
    }
    
    var bottomGradientColor: NSColor {
        get {
            return NSColor(calibratedRed: bottomGradientComponents[0], green: bottomGradientComponents[1], blue: bottomGradientComponents[2], alpha: bottomGradientComponents[3])
        }
        set (settingColor) {
            let color = settingColor.usingColorSpace(.deviceRGB)
            topGradientComponents = [color!.redComponent, color!.greenComponent, color!.blueComponent, color!.alphaComponent]
        }
    }
    
    var fontColor: NSColor {
        get {
            return NSColor(calibratedRed: fontComponents[0], green: fontComponents[1], blue: fontComponents[2], alpha: fontComponents[3])
        }
        set (settingColor) {
            let color = settingColor.usingColorSpace(.deviceRGB)
            topGradientComponents = [color!.redComponent, color!.greenComponent, color!.blueComponent, color!.alphaComponent]
        }
    }
}
