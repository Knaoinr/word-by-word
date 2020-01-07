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
    
    //drag out
    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        let songToMove = queue[indexPath.item]
        indexToDelete = indexPath.item
        return songToMove
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
