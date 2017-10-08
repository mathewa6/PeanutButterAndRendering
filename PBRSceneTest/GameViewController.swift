//
//  GameViewController.swift
//  PBRSceneTest
//
//  Created by Adi Mathew on 10/1/17.
//  Copyright © 2017 RCPD. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        // Assets from freepbr.com
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        let rotateAction: SCNAction = SCNAction.rotate(by: .pi,
                                                       around: SCNVector3(x: 0, y: 1, z: 0),
                                                       duration: 7.5)
        let
        ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        ship.runAction(SCNAction.repeatForever(rotateAction))
        
        // create and add a camera to the scene
        let
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()

        /*
         *
         *
         *
         
         --------------------------------------------------------------------------
         
         1. Run project and note memory usage in the Profiler/Debug tab.
         2. Uncomment the following motionBlurIntensity line and run the project.
         3. Monitor memory usage.
         4. Allocation Profiler shows a continous allocation of objects from
             -[SCNRenderer _renderSceneWithEngineContext:sceneTime:]
         
         
         cameraNode.camera?.motionBlurIntensity = 0.6
 
         --------------------------------------------------------------------------

         *
         *
         *
         */
        
        
        cameraNode.camera?.bloomIntensity = 1.5
        cameraNode.camera?.bloomThreshold = 0.5
        cameraNode.camera?.bloomBlurRadius = 2.5
        cameraNode.camera?.colorFringeStrength = 2.1
        cameraNode.camera?.colorFringeIntensity = 1.8
        
        if #available(iOS 11, *) {
            // Activate SSAO
            cameraNode.camera?.screenSpaceAmbientOcclusionIntensity = 12.0
            // Configure SSAO
            cameraNode.camera?.screenSpaceAmbientOcclusionRadius = 1.5 //scene units
            cameraNode.camera?.screenSpaceAmbientOcclusionBias = 0.3 //scene units
            cameraNode.camera?.screenSpaceAmbientOcclusionDepthThreshold = 0.2 //scene units
            cameraNode.camera?.screenSpaceAmbientOcclusionNormalThreshold = 0.3
        }
        
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 27)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
