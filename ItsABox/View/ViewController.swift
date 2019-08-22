//
//  ViewController.swift
//  ItsABox
//
//  Created by Bratislav Ljubisic on 07.06.19.
//  Copyright © 2019 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let sceneManager = ARSceneManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneManager.attach(to: sceneView)
        sceneManager.displayDebugInfo()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScene(_:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func didTapScene(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended:
            //1
            let location = gesture.location(ofTouch: 0,
                                            in: sceneView)

            //2
            let hit = sceneView.hitTest(location,
                                        types: .existingPlaneUsingGeometry)
            //3
            if let hit = hit.first {
                placeBlockOnPlaneAt(hit)
            }
        default:
            break
        }
    }
    
    func placeBlockOnPlaneAt(_ hit: ARHitTestResult) {
       //1
        let box = createBox()
        position(node: box, atHit: hit)
        //2
        sceneView?.scene.rootNode.addChildNode(box)
    }
    
    private func createBox() -> SCNNode {
        let box = SCNBox(width: 0.15, height: 0.20, length: 0.02, chamferRadius: 0.02)
        let boxNode = SCNNode(geometry: box)

        return boxNode
    }
    
    private func position(node: SCNNode, atHit hit: ARHitTestResult) {
        //1
        node.transform = SCNMatrix4(hit.anchor!.transform)
        //2
        node.eulerAngles = SCNVector3Make(node.eulerAngles.x + (Float.pi / 2), node.eulerAngles.y, node.eulerAngles.z)
        //3
        let position = SCNVector3Make(hit.worldTransform.columns.3.x + node.geometry!.boundingBox.min.z, hit.worldTransform.columns.3.y, hit.worldTransform.columns.3.z)
        node.position = position
    }
}
