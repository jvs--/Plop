//
//  GameScene.swift
//  Plop
//
//  Created by _jvs on 3/16/16.
//  Copyright (c) 2016 Meron Labs. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // Set background image
        //let bgImage = SKSpriteNode(imageNamed: "background")
        //bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        //bgImage.size = self.frame.size
        //bgImage.zPosition = 0
        //self.addChild(bgImage)
        
        let myLabel = SKLabelNode(fontNamed:"Avenir")
        myLabel.text = "tap to start"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        myLabel.zPosition = 1
        self.addChild(myLabel)
        
        // Define rotation action
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:2)

        // 
        let sprite2 = SKSpriteNode(imageNamed:"pancake")
        sprite2.position = CGPoint(x: 600, y: 600)
        sprite2.xScale = 0.5
        sprite2.yScale = 0.5
        sprite2.runAction(SKAction.repeatActionForever(action))
        self.addChild(sprite2)
        
        let sprite3 = SKSpriteNode(imageNamed:"whip")
        sprite3.position = CGPoint(x: 500, y: 200)
        sprite3.xScale = 0.5
        sprite3.yScale = 0.5
        sprite3.runAction(SKAction.repeatActionForever(action))
        self.addChild(sprite3)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        // Transition to next scene
        let scene = LevelScene(fileNamed: "LevelScene")!
        let transition = SKTransition.fadeWithDuration(1)
        self.view?.presentScene(scene, transition: transition)
    
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
