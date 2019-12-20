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
    
    let homePlayButton = NSButton()
    let homePlayImage = NSImageView()
    
    let homeSearchButton = NSButton()
    let homeSearchImage = NSImageView()
    let homeSearchLabel = NSTextField(string: "Search")
    let homeBrowseButton = NSButton()
    let homeBrowseImage = NSImageView()
    let homeBrowseLabel = NSTextField(string: "Browse")
    let homeAddButton = NSButton()
    let homeAddImage = NSImageView()
    let homeAddLabel = NSTextField(string: "Add")
    
    let cellSearch = NSView()
    let cellBrowse = NSView()
    let cellAdd = NSView()
    let homeStack = NSStackView()
    
    let homeButton = NSButton()
    
    let sideBarController = SideBarViewController()
    let sideBarButton  = NSButton()
    
    var contentHeight:CGFloat = 0
    var previousHeight:CGFloat = 0
    
    let peach = NSColor(calibratedRed: 1, green: 0.3, blue: 0.3, alpha: 1)
        
    // MARK: - Protocol
    
    override func loadView() {
        self.view = ColorView(frame: NSRect(x: 0, y: 0, width: AppDelegate.mainWindow!.frame.width, height: AppDelegate.mainWindow!.frame.height))
        self.scrollView.frame = view.frame
        self.view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        // Create all objects
        createObjects()
    }
    
    // MARK: - Action response methods
    
    @objc func onSideBarButtonPress() {
        view.addSubview(sideBarController.view)
    }
    
    // MARK: - Homemade functions
    
    // Place all objects & their properties
    func createObjects() {
                
        //Establish theme time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
                
        if hour >= 21 || hour < 5 { //night
            (self.view as! ColorView).changeGradientColor(start: .black, end: .blue)
            homePlayImage.image = NSImage(named: "play_purple")
            homeSearchImage.image = NSImage(named: "search_purple")
            homeBrowseImage.image = NSImage(named: "browse_purple")
            homeAddImage.image = NSImage(named: "add_purple")
            homeSearchLabel.textColor = .black
            homeBrowseLabel.textColor = .black
            homeAddLabel.textColor = .black
            homeSearchLabel.backgroundColor = NSColor(calibratedWhite: 1, alpha: 0.2)
            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
        } else if hour >= 9 && hour < 17 { //day
            (self.view as! ColorView).changeGradientColor(start: .orange, end: .white)
            homePlayImage.image = NSImage(named: "play_orange")
            homeSearchImage.image = NSImage(named: "search_orange")
            homeBrowseImage.image = NSImage(named: "browse_orange")
            homeAddImage.image = NSImage(named: "add_orange")
            homeSearchLabel.textColor = peach
            homeBrowseLabel.textColor = peach
            homeAddLabel.textColor = peach
            homeSearchLabel.backgroundColor = .clear
            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
        } else { //dawn/dusk
            (self.view as! ColorView).changeGradientColor(start: .systemIndigo, end: .systemOrange)
            homePlayImage.image = NSImage(named: "play_purple")
            homeSearchImage.image = NSImage(named: "search_purple")
            homeBrowseImage.image = NSImage(named: "browse_purple")
            homeAddImage.image = NSImage(named: "add_purple")
            homeSearchLabel.textColor = .black
            homeBrowseLabel.textColor = .black
            homeAddLabel.textColor = .black
            homeSearchLabel.backgroundColor = .clear
            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
        }
        
        //Setup main play button image
        homePlayImage.frame = NSRect(x: view.bounds.width/2 - 200/2, y: view.bounds.height - 200 - 100 - 20, width: 200, height: 200)
        contentHeight += 100 + homePlayImage.bounds.height
        homePlayButton.frame = homePlayImage.frame
        homePlayButton.isTransparent = true
        
        //Setup main search button image
        homeSearchImage.frame = NSRect(x: 0, y: 40, width: 100, height: 100)
        homeSearchButton.frame = NSRect(x: 0, y: 0, width: 100, height: 145)
        homeSearchButton.isTransparent = true
        
        homeSearchLabel.frame = NSRect(x: 0, y: 0, width: 100, height: 25)
        homeSearchLabel.isEditable = false
        homeSearchLabel.isSelectable = false
        homeSearchLabel.isBordered = false
        homeSearchLabel.font = .messageFont(ofSize: 20)
        homeSearchLabel.alignment = .center
        
        cellSearch.addSubview(homeSearchImage)
        cellSearch.addSubview(homeSearchLabel)
        cellSearch.addSubview(homeSearchButton)
        
        //Setup main browse button image
        homeBrowseImage.frame = homeSearchImage.frame
        homeBrowseButton.frame = homeSearchButton.frame
        homeBrowseButton.isTransparent = true
        
        homeBrowseLabel.frame = homeSearchLabel.frame
        homeBrowseLabel.isEditable = false
        homeBrowseLabel.isSelectable = false
        homeBrowseLabel.isBordered = false
        homeBrowseLabel.font = .messageFont(ofSize: 20)
        homeBrowseLabel.alignment = .center
        
        cellBrowse.addSubview(homeBrowseImage)
        cellBrowse.addSubview(homeBrowseLabel)
        cellBrowse.addSubview(homeBrowseButton)
        
        //Setup main add button image
        homeAddImage.frame = homeSearchImage.frame
        homeAddButton.frame = homeSearchButton.frame
        homeAddButton.isTransparent = true
        
        homeAddLabel.frame = homeSearchLabel.frame
        homeAddLabel.isEditable = false
        homeAddLabel.isSelectable = false
        homeAddLabel.isBordered = false
        homeAddLabel.font = .messageFont(ofSize: 20)
        homeAddLabel.alignment = .center
        
        cellAdd.addSubview(homeAddImage)
        cellAdd.addSubview(homeAddLabel)
        cellAdd.addSubview(homeAddButton)
        
        //Setup stack view
        homeStack.spacing = 80
        homeStack.frame = NSRect(x: view.bounds.width/2 - 150 - homeStack.spacing, y: view.bounds.height - 100 - homePlayImage.bounds.height - 30 - homeSearchButton.bounds.height - 20, width: 300 + 2*homeStack.spacing, height: 145)
        homeStack.orientation = .horizontal
        homeStack.distribution = .fillEqually
        homeStack.addArrangedSubview(cellSearch)
        homeStack.addArrangedSubview(cellBrowse)
        homeStack.addArrangedSubview(cellAdd)
        contentHeight += 30 + homeStack.bounds.height + 30

        //Setup scroll view
        scrollView.drawsBackground = false
        scrollView.verticalScrollElasticity = .none
        scrollView.documentView = NSView(frame: NSRect(x: 0, y: 0, width: view.bounds.width, height: max(contentHeight, view.bounds.height)))
        scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentView!.bounds.height - view.bounds.height))
        
        //Setup home button
        homeButton.frame = NSRect(x: view.bounds.width - 30, y: view.bounds.height - 30 - 20, width: 30, height: 30)
        homeButton.image = NSImage(named: NSImage.homeTemplateName)
        homeButton.isBordered = false
        
        //Setup side bar button
        sideBarButton.frame = NSRect(x: 0, y: view.bounds.height - 30 - 20, width: 30, height: 30)
        sideBarButton.image = NSImage(named: NSImage.rightFacingTriangleTemplateName)
        sideBarButton.isBordered = false
        sideBarButton.action = #selector(onSideBarButtonPress)

        //Add all to scrollView
        scrollView.documentView!.addSubview(homePlayImage)
        scrollView.documentView!.addSubview(homePlayButton)
        scrollView.documentView!.addSubview(homeStack)
        
        //Add outside of scrollView
        view.addSubview(homeButton)
        view.addSubview(sideBarButton)
        
        previousHeight = view.bounds.height
    }
    
    // Replace objects when frame changes
    func reposition(size: NSSize) {
        //change frames
        view.setFrameSize(size)
        scrollView.setFrameSize(size)
        scrollView.documentView!.setFrameSize(NSSize(width: size.width, height: max(contentHeight, size.height)))
        if contentHeight > size.height { //no extra room beneath, scrolling
            scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentVisibleRect.minY + (previousHeight - size.height)))
        } else { //extra room beneath (or just right), no scrolling
            scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentVisibleRect.maxY - size.height))
        }
        
        //change objects
        // -20 y for each for bar at top
        homePlayImage.setFrameOrigin(NSPoint(x: size.width/2 - 200/2, y: max(contentHeight, size.height) - homePlayImage.bounds.height - 100 - 20))
        homePlayButton.setFrameOrigin(homePlayImage.frame.origin)
        homeStack.setFrameOrigin(NSPoint(x: size.width/2 - 150 - homeStack.spacing, y: max(contentHeight, size.height) - 100 - homePlayImage.bounds.height - 30 - homeSearchButton.bounds.height - 20))
        homeButton.setFrameOrigin(NSPoint(x: size.width - homeButton.bounds.width, y: size.height - homeButton.bounds.width - 20))
        sideBarButton.setFrameOrigin(NSPoint(x: 0, y: size.height - sideBarButton.bounds.width - 20))
        
        sideBarController.reposition(size: size)
        
        
        previousHeight = size.height
    }
    
}
