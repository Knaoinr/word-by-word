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
    
    var nextViewController = AddSecondViewController(songTitle: "", songArtists: [], songLyrics: [], backView: nil)
    
    // MARK: - Protocol
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        cancelButton.action = #selector(cancel)
        nextButton.action = #selector(next)
    }
    
    override func close() {
        cancel()
    }
    
    // MARK: - Action response methods
    
    // Next/cancel buttons
    
    @objc func cancel() {
        (AppDelegate.mainWindow?.windowController as! HomeWindowController).addWindowArray.removeAll { (controller) -> Bool in
            return self.isEqual(to: controller)
        }
        window!.close()
    }
    
    @objc func next() {
        if titleTextField.stringValue != "" && artistTokenField.stringValue != "" && lyricTextView.string != "" {
            let artistArray = artistTokenField.objectValue as! Array<String>
            
            let lineArray = lyricTextView.string.split(separator: "\n")
            var lyricArray:[Array<String>] = []
            for x in 0...lineArray.count-1 {
                lyricArray.append([])
                for y in 0...lineArray[x].split(separator: " ").count - 1 {
                    lyricArray[x].append(String(lineArray[x].split(separator: " ")[y]))
                }
            }
            
            nextViewController = AddSecondViewController(songTitle: titleTextField.stringValue, songArtists: artistArray, songLyrics: lyricArray, backView: window!.contentView!)
            window!.contentViewController = nextViewController
        }
    }
    
    // Check if fields filled out
    
    @IBAction func onTitle(_ sender: NSTextField) {
        //if not all filled out (waiting on others)
        if titleTextField.stringValue == "" {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    //how to get the others in here?
    
}
