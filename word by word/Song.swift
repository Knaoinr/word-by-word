//
//  Song.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/26/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Foundation
import Cocoa

class Song : Codable {
    
    // MARK: - Variables
    
    var title = ""
    var artists:[String] = []
    var lyrics:[Array<String>] = []
    
    var timing:[Array<CGFloat>] = []
    var songLength:CGFloat = 0
    var firstLyric:CGFloat = 0
    
    var topGradientComponents = NSColor.clear.toComponents()
    var bottomGradientComponents = NSColor.clear.toComponents()
    var fontComponents = NSColor.white.toComponents()
    
    // MARK: - Methods
    
    init(title:String, artists:[String], lyrics:[Array<String>], songLength:CGFloat, firstLyric:CGFloat) {
        self.title = title
        self.artists = artists
        self.lyrics = lyrics
        self.songLength = songLength
        self.firstLyric = firstLyric
        
        resetTimingSize()
    }
    
    func setColors(topGradientColor:NSColor, bottomGradientColor:NSColor, fontColor:NSColor) {
        self.topGradientComponents = topGradientColor.toComponents()
        self.bottomGradientComponents = bottomGradientColor.toComponents()
        self.fontComponents = fontColor.toComponents()
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
}

extension NSColor {
    func toComponents() -> [CGFloat] {
        let color = self.usingColorSpace(.deviceRGB)
        return [color!.redComponent, color!.greenComponent, color!.blueComponent, color!.alphaComponent]
    }
}

extension Array where Element == CGFloat {
    func toColor() -> NSColor {
        if count == 4 {
            return NSColor(calibratedRed: self[0], green: self[1], blue: self[2], alpha: self[3])
        } else {
            return NSColor.clear
        }
    }
}
