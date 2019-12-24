//
//  AddWindowController.swift
//  word by word
//
//  Created by Kiera O'Flynn on 12/21/19.
//  Copyright © 2019 Knaoinr. All rights reserved.
//

import Cocoa

class AddWindowController: NSWindowController {
    
    // MARK: - Objects
    
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var artistTokenField: NSTokenField!
    @IBOutlet weak var lyricTextView: NSTextView!
    
    // MARK: - Methods
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        cancelButton.action = #selector(cancel)
        nextButton.action = #selector(next)
    }
    
    @objc func cancel() {
        print("close")
        window?.close()
    }
    
    @objc func next() {
        //
        print("next")
    }
    
}
