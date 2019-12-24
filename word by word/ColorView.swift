//
//  ColorView.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/14/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class ColorView: NSView {
    
    // MARK: - Objects
    
    var startColor = NSColor.clear
    var endColor = NSColor.clear

    // MARK: - Draw
    
    override func draw(_ dirtyRect:NSRect) {
        if let gradient = NSGradient(starting: startColor, ending: endColor) {
            gradient.draw(in: dirtyRect, angle: 270)
        }
    }

    // MARK: - Methods
    
    func changeGradientColor(start: NSColor, end: NSColor) {
        startColor = start
        endColor = end
        setNeedsDisplay(self.bounds)
    }

}
