//
//  SearchySearchField.swift
//  word by word
//
//  Created by Kiera O'Flynn on 1/8/20.
//  Copyright © 2020 Knaoinr. All rights reserved.
//

import Cocoa

class SearchySearchField: NSSearchField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func rectForSearchButton(whenCentered isCentered: Bool) -> NSRect {
        return NSRect(x: 0, y: 15, width: 40, height: 40)
    }
    
    override func rectForSearchText(whenCentered isCentered: Bool) -> NSRect {
        let rect = super.rectForSearchText(whenCentered: isCentered)
        return NSRect(x: rect.minX + 30, y: rect.minY, width: rect.width, height: rect.height)
    }
    
}
