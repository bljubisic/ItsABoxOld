//
//  ARSceneManager.swift
//  ItsABox
//
//  Created by Bratislav Ljubisic on 14.08.19.
//  Copyright © 2019 Bratislav Ljubisic. All rights reserved.
//

import Foundation
import ARKit

class ARSceneManager: NSObject {
    var sceneView: ARSCNView?
    
    private var planes = [UUID: Plane]()
    
    func attach(to sceneView: ARSCNView) {
        self.sceneView = sceneView
        
        self.sceneView!.delegate = self
        
        self.configureSceneView(self.sceneView!)
    }
    
    func displayDebugInfo() {
        guard let scView = self.sceneView else { return }
        
        scView.showsStatistics = true
        scView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
    }
    
    var defaultConfiguration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        return configuration
    }
    
    private func configureSceneView(_ sceneView: ARSCNView) {
        sceneView.session.run(self.defaultConfiguration)
    }
}

extension ARSceneManager: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let plane = Plane(anchor: planeAnchor)
        planes[anchor.identifier] = plane
        

        
        node.addChildNode(plane)    
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        if let plane = planes[anchor.identifier] {
            plane.updateWith(anchor: planeAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        planes.removeValue(forKey: anchor.identifier)
    }
    
}
