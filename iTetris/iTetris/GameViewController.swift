//
//  GameViewController.swift
//  iTetris
//
//  Created by Bruno Da luz on 11/04/16.
//  Copyright (c) 2016 Bruno v0id. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var swiftris: Swiftris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = false
        
        // create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
      
        swiftris = Swiftris()
        swiftris.beginGame()
        
        skView.presentScene(scene)
        
        scene.addPreviewShapeToScene(swiftris.nextShape!) { 
            self.swiftris.nextShape?.moveTo(StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(self.swiftris.nextShape!, completion: {
                let nextShapes = self.swiftris.nextShape
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes!, completion: {})
            })
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.readrawShape(swiftris.fallingShape!, completion: {})
    }

}
