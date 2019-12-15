//
//  HomeViewController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/11/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa
import SwiftUI

class HomeViewController: NSViewController {
    
    // MARK: - Objects
    
    let scrollView = NSScrollView()
    let colorView = ColorView()
    
    let homeplayButton = NSButton()
    let homeplayImage = NSImageView()
    
    var contentHeight:CGFloat = 0
    var previousSize:CGFloat = 0
        
    // MARK: - Protocol
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: AppDelegate.mainWindow!.frame.width, height: AppDelegate.mainWindow!.frame.height))
        self.colorView.frame = view.frame
        self.scrollView.frame = view.frame
        view.addSubview(colorView)
        colorView.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        // Create all objects
        createObjects()
        }
    
    // MARK: - Homemade functions
    
    // Place all objects & their properties
    func createObjects() {
                
        //Establish theme time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour >= 21 || hour < 5 { //night
            colorView.changeGradientColor(start: .black, end: .blue)
            homeplayImage.image = NSImage(named: "play_purple")
        } else if hour >= 9 && hour < 17 { //day
            colorView.changeGradientColor(start: .orange, end: .white)
            homeplayImage.image = NSImage(named: "play_orange")
        } else { //dawn/dusk
            colorView.changeGradientColor(start: .black, end: .purple)
            homeplayImage.image = NSImage(named: "play_purple")
        }
        
        //Setup main play button image
        homeplayImage.frame = NSRect(x: view.bounds.width/2 - 200/2, y: view.bounds.height - 200 - 100, width: 200, height: 200)
        contentHeight += 100 + homeplayImage.bounds.height
        homeplayButton.frame = homeplayImage.frame
        homeplayButton.isTransparent = true

        //Setup scroll view
        scrollView.drawsBackground = false
        scrollView.verticalScrollElasticity = .none
        scrollView.documentView = NSView(frame: NSRect(x: 0, y: 0, width: view.bounds.width, height: max(contentHeight, view.bounds.height)))
        scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentView!.bounds.height - view.bounds.height))

        //Add all to colorView
        scrollView.documentView!.addSubview(homeplayImage)
        scrollView.documentView!.addSubview(homeplayButton)
        
        previousSize = view.bounds.height
    }
    
    // Replace objects when frame changes
    func reposition(size: NSSize) {
        colorView.setFrameSize(size)
        scrollView.setFrameSize(size)
        scrollView.documentView!.setFrameSize(NSSize(width: size.width, height: max(contentHeight, size.height)))
        if size.height < previousSize { //decreasing
            scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentView!.bounds.height - size.height))
        } else if size.height > previousSize { //increasing or =
            scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentVisibleRect.maxY - size.height))
        }

        homeplayImage.setFrameOrigin(NSPoint(x: size.width/2 - 200/2, y: max(contentHeight, size.height) - homeplayImage.bounds.height - 100))
        homeplayButton.setFrameOrigin(homeplayImage.frame.origin)
        
        previousSize = size.height
    }
    
}
