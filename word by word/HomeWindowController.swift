//
//  HomeWindowController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/24/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class HomeWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    // MARK: - Action response methods
    
    @objc func onMainPlayButtonPress() {
        //
    }
    
    @objc func onSearchButtonPress() {
        //
    }
    
    @objc func onBrowseButtonPress() {
        //
    }
    
    @objc func onAddButtonPress() {
//        let addWindowController = AddWindowController(windowNibName: "AddWindowController")
//        addWindowArray.append(addWindowController)
//        addWindowController.window?.makeKeyAndOrderFront(self)
    }
    
    @objc func onSideBarButtonPress() {
//        view.addSubview(sideBarController.view)
    }
    
    // MARK: - Homemade functions
    
    // Place all objects & their properties
    func createObjects() {
                
        //Establish theme time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
                
//        if hour >= 21 || hour < 5 { //night
//            (self.view as! ColorView).changeGradientColor(start: .black, end: .blue)
//            homePlayImage.image = NSImage(named: "play_purple")
//            homeSearchImage.image = NSImage(named: "search_purple")
//            homeBrowseImage.image = NSImage(named: "browse_purple")
//            homeAddImage.image = NSImage(named: "add_purple")
//            homeSearchLabel.textColor = .black
//            homeBrowseLabel.textColor = .black
//            homeAddLabel.textColor = .black
//            homeSearchLabel.backgroundColor = NSColor(calibratedWhite: 1, alpha: 0.2)
//            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
//            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
//        } else if hour >= 9 && hour < 17 { //day
//            (self.view as! ColorView).changeGradientColor(start: .orange, end: .white)
//            homePlayImage.image = NSImage(named: "play_orange")
//            homeSearchImage.image = NSImage(named: "search_orange")
//            homeBrowseImage.image = NSImage(named: "browse_orange")
//            homeAddImage.image = NSImage(named: "add_orange")
//            homeSearchLabel.textColor = peach
//            homeBrowseLabel.textColor = peach
//            homeAddLabel.textColor = peach
//            homeSearchLabel.backgroundColor = .clear
//            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
//            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
//        } else { //dawn/dusk
//            (self.view as! ColorView).changeGradientColor(start: .systemIndigo, end: .systemOrange)
//            homePlayImage.image = NSImage(named: "play_purple")
//            homeSearchImage.image = NSImage(named: "search_purple")
//            homeBrowseImage.image = NSImage(named: "browse_purple")
//            homeAddImage.image = NSImage(named: "add_purple")
//            homeSearchLabel.textColor = .black
//            homeBrowseLabel.textColor = .black
//            homeAddLabel.textColor = .black
//            homeSearchLabel.backgroundColor = .clear
//            homeBrowseLabel.backgroundColor = homeSearchLabel.backgroundColor!
//            homeAddLabel.backgroundColor = homeSearchLabel.backgroundColor!
//        }
//
//        //Setup main play button image
//        homePlayImage.frame = NSRect(x: view.bounds.width/2 - 200/2, y: view.bounds.height - 200 - 100 - 20, width: 200, height: 200)
//        contentHeight += 100 + homePlayImage.bounds.height
//        homePlayButton.frame = homePlayImage.frame
//        homePlayButton.isTransparent = true
//        homePlayButton.action = #selector(onMainPlayButtonPress)
//
//        //Setup main search button image
//        homeSearchImage.frame = NSRect(x: 0, y: 40, width: 100, height: 100)
//        homeSearchButton.frame = NSRect(x: 0, y: 0, width: 100, height: 145)
//        homeSearchButton.isTransparent = true
//        homeSearchButton.action = #selector(onSearchButtonPress)
//
//        homeSearchLabel.frame = NSRect(x: 0, y: 0, width: 100, height: 25)
//        homeSearchLabel.isEditable = false
//        homeSearchLabel.isSelectable = false
//        homeSearchLabel.isBordered = false
//        homeSearchLabel.font = .messageFont(ofSize: 20)
//        homeSearchLabel.alignment = .center
//
//        cellSearch.addSubview(homeSearchImage)
//        cellSearch.addSubview(homeSearchLabel)
//        cellSearch.addSubview(homeSearchButton)
//
//        //Setup main browse button image
//        homeBrowseImage.frame = homeSearchImage.frame
//        homeBrowseButton.frame = homeSearchButton.frame
//        homeBrowseButton.isTransparent = true
//        homeBrowseButton.action = #selector(onBrowseButtonPress)
//
//        homeBrowseLabel.frame = homeSearchLabel.frame
//        homeBrowseLabel.isEditable = false
//        homeBrowseLabel.isSelectable = false
//        homeBrowseLabel.isBordered = false
//        homeBrowseLabel.font = .messageFont(ofSize: 20)
//        homeBrowseLabel.alignment = .center
//
//        cellBrowse.addSubview(homeBrowseImage)
//        cellBrowse.addSubview(homeBrowseLabel)
//        cellBrowse.addSubview(homeBrowseButton)
//
//        //Setup main add button image
//        homeAddImage.frame = homeSearchImage.frame
//        homeAddButton.frame = homeSearchButton.frame
//        homeAddButton.isTransparent = true
//        homeAddButton.action = #selector(onAddButtonPress)
//
//        homeAddLabel.frame = homeSearchLabel.frame
//        homeAddLabel.isEditable = false
//        homeAddLabel.isSelectable = false
//        homeAddLabel.isBordered = false
//        homeAddLabel.font = .messageFont(ofSize: 20)
//        homeAddLabel.alignment = .center
//
//        cellAdd.addSubview(homeAddImage)
//        cellAdd.addSubview(homeAddLabel)
//        cellAdd.addSubview(homeAddButton)
//
//        //Setup stack view
//        homeStack.spacing = 80
//        homeStack.frame = NSRect(x: view.bounds.width/2 - 150 - homeStack.spacing, y: view.bounds.height - 100 - homePlayImage.bounds.height - 30 - homeSearchButton.bounds.height - 20, width: 300 + 2*homeStack.spacing, height: 145)
//        homeStack.orientation = .horizontal
//        homeStack.distribution = .fillEqually
//        homeStack.addArrangedSubview(cellSearch)
//        homeStack.addArrangedSubview(cellBrowse)
//        homeStack.addArrangedSubview(cellAdd)
//        contentHeight += 30 + homeStack.bounds.height + 30
//
//        //Setup scroll view
//        scrollView.drawsBackground = false
//        scrollView.verticalScrollElasticity = .none
//        scrollView.documentView = NSView(frame: NSRect(x: 0, y: 0, width: view.bounds.width, height: max(contentHeight, view.bounds.height)))
//        scrollView.contentView.scroll(to: NSPoint(x: 0, y: scrollView.documentView!.bounds.height - view.bounds.height))
//
//        //Setup home button
//        homeButton.frame = NSRect(x: view.bounds.width - 30, y: view.bounds.height - 30 - 20, width: 30, height: 30)
//        homeButton.image = NSImage(named: NSImage.homeTemplateName)
//        homeButton.isBordered = false
//
//        //Setup side bar button
//        sideBarButton.frame = NSRect(x: 0, y: view.bounds.height - 30 - 20, width: 30, height: 30)
//        sideBarButton.image = NSImage(named: NSImage.rightFacingTriangleTemplateName)
//        sideBarButton.isBordered = false
//        sideBarButton.action = #selector(onSideBarButtonPress)
//
//        //Add all to scrollView
//        scrollView.documentView!.addSubview(homePlayImage)
//        scrollView.documentView!.addSubview(homePlayButton)
//        scrollView.documentView!.addSubview(homeStack)
//
//        //Add outside of scrollView
//        view.addSubview(homeButton)
//        view.addSubview(sideBarButton)
//
//        previousHeight = view.bounds.height
    }
    
}
