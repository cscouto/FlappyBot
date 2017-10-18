//
//  GameScene.swift
//  FlappyBot
//
//  Created by Couto on 10/18/17.
//  Copyright © 2017 coutocode. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    
    enum ColliderType: UInt32 {
        
        case Bird = 1
        case Object = 2
        
    }
    
    var gameOver = false
    
    @objc func makePipes() {
        
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        let gapHeight = bird.size.height * 4
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.run(moveAndRemovePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe1.physicsBody!.isDynamic = false
        
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        
        self.addChild(pipe1)
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipe2Texture.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.run(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe2.physicsBody!.isDynamic = false
        
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        self.addChild(pipe2)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("We have contact!")
        
        self.speed = 0
        
        gameOver = true
        
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
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
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        bird.physicsBody!.isDynamic = false
        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        self.addChild(bird)
        
        let ground = SKNode()
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.midY/2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        self.addChild(ground)
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
