//
//  SelectedAssetConverter.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/06/21.
//

import UIKit
import Photos


class SelectedAssetConverter {
    private let requestOptions: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        
        return options
    }()
    private var images: [UIImage] = []
   
    public func convertToImage(from assets: [SelectedPHAsset], size: CGSize) -> [UIImage] {
        
        assets.forEach { asset in
            PHImageManager.default().requestImage(for: asset.getAsset(), targetSize: size, contentMode: .aspectFill, options: requestOptions, resultHandler: { image, _ in
                guard let image = image else { return }
                self.images.append(image)
            })
        }
        
        return self.images
    }
}
