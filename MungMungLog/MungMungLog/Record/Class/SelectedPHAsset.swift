//
//  SelectedPHAsset.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/20.
//

import Foundation
import Photos

class SelectedPHAsset {
    private let asset: PHAsset
    private let indexPath: IndexPath
    
    public init(asset: PHAsset, indexPath: IndexPath) {
        self.asset = asset
        self.indexPath = indexPath
    }
    
    public func getAsset() -> PHAsset {
        return self.asset
    }
    
    public func getIndexPath() -> IndexPath {
        return self.indexPath
    }
}

