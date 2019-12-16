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
    
    let homePlayButton = NSButton()
    let homePlayImage = NSImageView()
    
    let homeSearchButton = NSButton()
    let homeSearchImage = NSImageView()
    let homeBrowseButton = NSButton()
    let homeBrowseImage = NSImageView()
    let homeAddButton = NSButton()
    let homeAddImage = NSImageView()
    
    let cellSearch = NSView()
    let cellBrowse = NSView()
    let cellAdd = NSView()
    let homeStack = NSStackView()
    
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
            homePlayImage.image = NSImage(named: "play_purple")
            homeSearchImage.image = NSImage(named: "search_purple")
            homeBrowseImage.image = NSImage(named: "search_purple")
            homeAddImage.image = NSImage(named: "search_purple")
        } else if hour >= 9 && hour < 17 { //day
            colorView.changeGradientColor(start: .orange, end: .white)
            homePlayImage.image = NSImage(named: "play_orange")
            homeSearchImage.image = NSImage(named: "search_orange")
            homeBrowseImage.image = NSImage(named: "search_purple")
            homeAddImage.image = NSImage(named: "search_purple")
        } else { //dawn/dusk
            colorView.changeGradientColor(start: .black, end: .purple)
            homePlayImage.image = NSImage(named: "play_purple")
            homeSearchImage.image = NSImage(named: "search_purple")
            homeBrowseImage.image = NSImage(named: "search_purple")
            homeAddImage.image = NSImage(named: "search_purple")
        }
        
        //Setup main play button image
        homePlayImage.frame = NSRect(x: view.bounds.width/2 - 200/2, y: view.bounds.height - 200 - 100, width: 200, height: 200)
        contentHeight += 100 + homePlayImage.bounds.height
        homePlayButton.frame = homePlayImage.frame
        homePlayButton.isTransparent = true
        
        //Setup main search button image
        homeSearchImage.frame = NSRect(x: 0, y: 0, width: 100, height: 100)
        homeSearchButton.frame = homeSearchImage.frame
        homeSearchButton.isTransparent = true
        
        cellSearch.addSubview(homeSearchImage)
        cellSearch.addSubview(homeSearchButton)
        
        //Setup main browse button image
        homeBrowseImage.frame = homeSearchImage.frame
        homeBrowseButton.frame = homeBrowseImage.frame
        homeBrowseButton.isTransparent = true
        
        cellBrowse.addSubview(homeBrowseImage)
        cellBrowse.addSubview(homeBrowseButton)
        
        //Setup main add button image
        homeAddImage.frame = homeSearchImage.frame
        homeAddButton.frame = homeAddImage.frame
        homeAddButton.isTransparent = true
        
        cellAdd.addSubview(homeAddImage)
        cellAdd.addSubview(homeAddButton)
        
        //Setup stack view
        homeStack.spacing = 80
        homeStack.frame = NSRect(x: view.bounds.width/2 - 150 - homeStack.spacing, y: view.bounds.height - 100 - homePlayImage.bounds.height - 150, width: 300 + 2*homeStack.spacing, height: 100)
        homeStack.orientation = .horizontal
        homeStack.distribution = .fillEqually
        homeStack.addArrangedSubview(cellSearch)
        homeStack.addArrangedSubview(cellBrowse)
        homeStack.addArrangedSubview(cellAdd)
        contentHeight += 150 + homeStack.bounds.height

        //Setup scroll view
        scrollView.drawsBackground = false
        scrollView.verticalScrollElasticity = .none
        scrollView.documentView = NSView(frame: NSRect(x: 0, y: 0, width: view.bounds.width, height: max(contentHeight, view.bounds.height)))
        scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentView!.bounds.height - view.bounds.height))

        //Add all to scrollView
        scrollView.documentView!.addSubview(homePlayImage)
        scrollView.documentView!.addSubview(homePlayButton)
        scrollView.documentView!.addSubview(homeStack)
        
        previousSize = view.bounds.height
    }
    
    // Replace objects when frame changes
    func reposition(size: NSSize) {
        //change frames
        colorView.setFrameSize(size)
        scrollView.setFrameSize(size)
        scrollView.documentView!.setFrameSize(NSSize(width: size.width, height: max(contentHeight, size.height)))
        if size.height < previousSize { //decreasing
            scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentView!.bounds.height - size.height))
        } else if size.height > previousSize { //increasing
            scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentVisibleRect.maxY - size.height))
        }

        //change objects
        homePlayImage.setFrameOrigin(NSPoint(x: size.width/2 - 200/2, y: max(contentHeight, size.height) - homePlayImage.bounds.height - 100))
        homePlayButton.setFrameOrigin(homePlayImage.frame.origin)
        homeStack.setFrameOrigin(NSPoint(x: size.width/2 - 150 - homeStack.spacing, y: max(contentHeight, size.height) - 100 - homePlayImage.bounds.height - 150))
        
        previousSize = size.height
    }
    
}
