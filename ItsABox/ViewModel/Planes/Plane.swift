//
//  Plane.swift
//  ItsABox
//
//  Created by Bratislav Ljubisic on 14.08.19.
//  Copyright © 2019 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import ARKit

class Plane: SCNNode {
    let plane: SCNPlane
    
    init(anchor: ARPlaneAnchor) {
        plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        super.init()
        
        plane.cornerRadius = 0.05
        
        plane.materials = [GridMaterial()]
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        planeNode.eulerAngles.x = -.pi / 2
        
        addChildNode(planeNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(anchor: ARPlaneAnchor) {
        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
        
        if let grid = plane.materials.first as? GridMaterial {
            grid.updateWith(anchor: anchor)
        }
        
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
    }
    
}
