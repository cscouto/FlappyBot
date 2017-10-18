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
        let bgTexture = SKTexture(imageNamed: "bg.png")
        let moveBgAnimation = SKAction.move(by: CGVector(dx: -1, dy: 0), duration: 0.1)
        let moveBgForever = SKAction.repeatForever(moveBgAnimation)
        bg.texture = bgTexture
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bg.size.height = self.frame.height
        bg.run(moveBgForever)
        self.addChild(bg)
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        bird.texture = birdTexture
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bird.run(makeBirdFlap)
        self.addChild(bird)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
