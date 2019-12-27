//
//  SideBarViewController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/19/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class SideBarViewController: NSViewController {
    
    // MARK: - Objects
    
    let scrollView = NSScrollView()
    
    let sideBarButton = NSButton()
    let queueLabel = NSTextField(string: "Queue")
    let dividingLine = ColorView()

    // MARK: - Protocol
    
    override func loadView() {
        self.view = ColorView(frame: NSRect(x: 0, y: 0, width: 150, height: 600))
        self.scrollView.frame = view.frame
        scrollView.drawsBackground = false
        view.addSubview(scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        // Create all objects
        createObjects()
    }
    
    // MARK: - Action response methods
    
    @objc func onSideBarButtonPress() {
        (AppDelegate.mainWindow!.windowController as! HomeWindowController).sideBarButton.isHidden = false
        view.removeFromSuperview()
    }
    
    // MARK: - Homemade methods
    
    func createObjects() {
        //Establish theme time
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        let blackTranslucent = NSColor(calibratedRed: 0, green: 0, blue: 0.1, alpha: 0.5)
        let greyTranslucent = NSColor(calibratedRed: 0.7, green: 0.8, blue: 0.6, alpha: 0.4)
        
        //Setup dividing line
        dividingLine.frame = NSRect(x: 10, y: view.bounds.height - 30 - 2 - 20, width: 100, height: 2)

        if hour >= 21 || hour < 5 { //night -> light
            (self.view as! ColorView).changeGradientColor(start: greyTranslucent, end: greyTranslucent)
            queueLabel.textColor = .black
            dividingLine.changeGradientColor(start: .black, end: .black)
        } else { //day, dawn/dusk -> dark
            (self.view as! ColorView).changeGradientColor(start: blackTranslucent, end: blackTranslucent)
            queueLabel.textColor = .lightGray
            dividingLine.changeGradientColor(start: .lightGray, end: .lightGray)
        }
        
        //Setup side bar button
        sideBarButton.frame = NSRect(x: 0, y: view.bounds.height - 30 - 20, width: 30, height: 30)
        sideBarButton.image = NSImage(named: NSImage.leftFacingTriangleTemplateName)
        sideBarButton.isBordered = false
        sideBarButton.action = #selector(onSideBarButtonPress)
        sideBarButton.target = self
        
        //Setup queue label
        queueLabel.frame = NSRect(x: 30, y: view.bounds.height - 20 - 20, width: 100, height: 15)
        queueLabel.isEditable = false
        queueLabel.isSelectable = false
        queueLabel.isBordered = false
        queueLabel.drawsBackground = false
        queueLabel.font = .messageFont(ofSize: 15)
        queueLabel.alignment = .left
        
        view.addSubview(sideBarButton)
        view.addSubview(queueLabel)
        view.addSubview(dividingLine)
    }
    
    func reposition(size: NSSize) {
        view.setFrameSize(NSSize(width: view.bounds.width, height: size.height))
        sideBarButton.setFrameOrigin(NSPoint(x: 0, y: size.height - 30 - 20))
        queueLabel.setFrameOrigin(NSPoint(x: 30, y: size.height - 20 - 20))
        dividingLine.setFrameOrigin(NSPoint(x: 10, y: size.height - 30 - 2 - 20))
        scrollView.setFrameSize(NSSize(width: view.bounds.width, height: size.height - sideBarButton.bounds.height - 30 - 30))
    }
    
}
