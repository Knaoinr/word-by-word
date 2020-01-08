//
//  SearchySearchCell.swift
//  word by word
//
//  Created by Kiera O'Flynn on 1/8/20.
//  Copyright © 2020 Knaoinr. All rights reserved.
//

import Cocoa

class SearchySearchCell: NSSearchFieldCell {
    
    override func searchButtonRect(forBounds rect: NSRect) -> NSRect {
        searchButtonCell!.imageScaling = .scaleAxesIndependently
        return NSRect(x: 0, y: 3, width: 40, height: 40)
    }

}
