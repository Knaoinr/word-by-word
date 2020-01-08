//
//  SideBarDataAndDelegate.swift
//  word by word
//
//  Created by Kiera O'Flynn on 1/2/20.
//  Copyright © 2020 Knaoinr. All rights reserved.
//

import Cocoa

class SideBarDataAndDelegate: NSObject, NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    //MARK: - Variables
    
    var queue:[Song] = []
    var indexToDelete:Int?
    
    //MARK: - Protocol
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return queue.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = SideBarCollectionViewItem(queue[indexPath.item])
        return item
    }
    
    //MARK: - selection
    
    func collectionView(_ collectionView: NSCollectionView, didChangeItemsAt indexPaths: Set<IndexPath>, to highlightState: NSCollectionViewItem.HighlightState) {
        if highlightState == .forSelection {
            //highlight
            for path in indexPaths {
                //set cell to highlighted
                ((collectionView.item(at: path) as! SideBarCollectionViewItem).view as! ColorView).changeGradientColor(start: .gray, end: .gray)
            }
        } else if highlightState == .none || highlightState == .forDeselection {
            //unhighlight
            for path in indexPaths {
                //set cell to regular
                if !collectionView.item(at: path)!.isSelected {
                    ((collectionView.item(at: path) as! SideBarCollectionViewItem).view as! ColorView).changeGradientColor(start: .clear, end: .clear)
                }
            }
        }
    }
    
    //change highlight state on programmatic de/selection as well as regular
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.delegate!.collectionView?(collectionView, didChangeItemsAt: indexPaths, to: .forDeselection)
    }
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        collectionView.delegate!.collectionView?(collectionView, didChangeItemsAt: indexPaths, to: .forSelection)
    }
    
    //MARK: - drag
    
    //drag out
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        let songToMove = queue[indexPath.item]
        indexToDelete = indexPath.item
        return songToMove
    }
    
    //delete by drag outside side bar
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        //put side bar in screen coords
        let sideBarRect = AppDelegate.mainWindow!.convertToScreen((AppDelegate.mainWindow!.windowController as! HomeWindowController).sideBarView.frame)
        //if outside CV
        if (!sideBarRect.contains(screenPoint)) {
            if (indexToDelete != nil) {
                queue.remove(at: indexToDelete!)
                indexToDelete = nil
            }
            collectionView.reloadData()
        }
    }
    
    //drag in
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        return .move
    }
    
    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
        //add at index (must be in range)
        var index = indexPath.item
        if indexToDelete != nil {
            queue.remove(at: indexToDelete!)
            if index > indexToDelete! {
                index -= 1
            }
            indexToDelete = nil
        }
        if index > queue.endIndex {
            index = queue.endIndex
        }
        queue.insert(Song(pasteboardPropertyList: draggingInfo.draggingPasteboard.propertyList(forType: .customSong)!, ofType: .customSong)!, at: index)
        collectionView.reloadData()

        return true
    }
    
}
