//
//  ScrollessScroller.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/29/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class ScrollessScroller: NSScroller {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override class func scrollerWidth(for controlSize: NSControl.ControlSize, scrollerStyle: NSScroller.Style) -> CGFloat {
        return 0
    }
    
}
