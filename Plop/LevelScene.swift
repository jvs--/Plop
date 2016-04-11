
//
//  LevelScene.swift
//  Plop
//
//  Created by _jvs on 3/16/16.
//  Copyright © 2016 Meron Labs. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class LevelScene: SKScene {
    var plop : AVAudioPlayer?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Set edge of the frame as "end of the world"
        // Such that objects bounce off
        let sceneBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        
        // Set gravity to be like in real world
        self.physicsWorld.gravity = CGVectorMake(0, -9.8)
        
        // Load audio for later use
        if let plop = self.setupAudioPlayerWithFile("plop", type:"wav") {
            self.plop = plop
        }
        
        //makeBackground()
        
        // Add goal
        let goal = SKSpriteNode(imageNamed:"goal")
        goal.position = CGPoint(x: 150, y: 500)
        goal.zPosition = 2
        goal.xScale = 0.5
        goal.yScale = 0.5
        goal.name = "goal"
      
        self.addChild(goal)


    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        // If any of the nodes have reached the goal hight transition to winning scene
        for child in self.children{
            if (child.position.y > 450) && (child.name != "goal"){
                print("FOO")
                let scene = WonScene(fileNamed: "WonScene")
                let transition = SKTransition.fadeWithDuration(0.5)
                self.view?.presentScene(scene!, transition: transition)
            }
        }
        if let touch = touches.first {
            
            // Get a random picture for the sprite
            let array = ["pancake", "whip", "berry"]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            // Create a Sprite
            let box = SKSpriteNode(imageNamed: array[randomIndex])
            // Actual size and physical size are different given the illusion of stacking
            box.size = CGSize(width: 80, height: 80)
            
            // Set its physical properties and location
            box.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
            let location = touch.locationInNode(self)
            box.position = location
            box.zPosition = 3
            box.physicsBody?.dynamic = true
            box.physicsBody?.affectedByGravity = true
            box.physicsBody?.restitution = 0.75
            addChild(box)
            
            //Play plop when object is placed
            self.plop?.play()
            
        
        }
        
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
}

