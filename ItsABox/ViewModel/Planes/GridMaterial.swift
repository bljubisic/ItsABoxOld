//
//  GridMaterial.swift
//  ItsABox
//
//  Created by Bratislav Ljubisic on 14.08.19.
//  Copyright © 2019 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import ARKit

class GridMaterial: SCNMaterial {

    override init() {
        super.init()
        
        let image = UIImage(named: "Grid")
        
        diffuse.contents = image
        diffuse.wrapS = .repeat
        diffuse.wrapT = .repeat
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(anchor: ARPlaneAnchor) {
        // 1
        let mmPerMeter: Float = 1000
        let mmOfImage: Float = 65
        let repeatAmount: Float = mmPerMeter / mmOfImage

        // 2
        diffuse.contentsTransform = SCNMatrix4MakeScale(anchor.extent.x * repeatAmount, anchor.extent.z * repeatAmount, 1)
    }
}
