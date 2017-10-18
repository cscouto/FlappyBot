//
//  GameScene.swift
//  FlappyBot
//
//  Created by Couto on 10/18/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        let bgTexture = SKTexture(imageNamed: "bg")
        let moveBgAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 7)
        let shiftBgAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width,dy: 0), duration: 0)
        let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBgAnimation, shiftBgAnimation]))
        
        var i: CGFloat = 0
        
        while i < 3{
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width * i, y: self.frame.midY)
            bg.size.height = self.frame.height
            bg.run(moveBgForever)
            bg.zPosition = -1
            self.addChild(bg)
            i += 1
        }
        
        let birdTexture = SKTexture(imageNamed: "flappy1")
        let birdTexture2 = SKTexture(imageNamed: "flappy2")
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bird.run(makeBirdFlap)
        self.addChild(bird)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let birdTexture = SKTexture(imageNamed: "flappy1")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 80))
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
