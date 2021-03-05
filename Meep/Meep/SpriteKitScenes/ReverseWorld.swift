//
//  ReverseWorld.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SpriteKit

public class ReverseWorld: SKScene, SKPhysicsContactDelegate {

    public var timeRift: SKSpriteNode!
    public var key: SKSpriteNode!
    public var rotatePlatform: SKSpriteNode!
    public var cameraNode: SKCameraNode!
    public var cameraMove: Bool!
    public var player: Player!
    public var lang: String?

    convenience init?(fileNamed: String, lang: String) {
        self.init(fileNamed: fileNamed)
        self.lang = lang
    }
    
    public override func didMove(to view: SKView) {
        
        self.cameraMove = true
        self.size = CGSize(width: 4096, height: 768)
        self.scaleMode = .aspectFill
        self.physicsWorld.contactDelegate = self
        
        let rotatePlatformActionSequence = SKAction.sequence([rotatePlatformAction(), .wait(forDuration: 2), rotatePlatformAction(), .wait(forDuration: 2)])
        
        enumerateChildNodes(withName: "//FlyingPlatform") {
            node, stop in
            if let platform = node as? SKSpriteNode {
                platform.physicsBody = .init(rectangleOf: platform.size)
                platform.physicsBody?.isDynamic = false
                platform.physicsBody?.affectedByGravity = false
                platform.physicsBody?.allowsRotation = false
                platform.physicsBody?.usesPreciseCollisionDetection = true
                platform.physicsBody?.categoryBitMask = categoryMask.flyingPlatform.rawValue
                platform.physicsBody?.collisionBitMask = categoryMask.player.rawValue
                platform.physicsBody?.contactTestBitMask = categoryMask.player.rawValue
                platform.physicsBody?.density = 100
                self.flying(platform: platform)
            }
        }

        enumerateChildNodes(withName: "//Wall") {
            node, stop in
            if let wall = node as? SKSpriteNode {
                wall.physicsBody = .init(rectangleOf: wall.size)
                wall.physicsBody?.isDynamic = false
                wall.physicsBody?.affectedByGravity = false
                wall.physicsBody?.allowsRotation = false
                wall.physicsBody?.usesPreciseCollisionDetection = true
                wall.physicsBody?.friction = 0
                wall.physicsBody?.restitution = 0
                wall.physicsBody?.categoryBitMask = categoryMask.wall.rawValue
                wall.physicsBody?.collisionBitMask = categoryMask.player.rawValue
                wall.physicsBody?.contactTestBitMask = categoryMask.player.rawValue
                wall.physicsBody?.density = 100
            }
        }
        
        enumerateChildNodes(withName: "//Floor") {
            node, stop in
            if let floor = node as? SKSpriteNode {
                floor.physicsBody = .init(rectangleOf: floor.size)
                floor.physicsBody?.isDynamic = false
                floor.physicsBody?.affectedByGravity = false
                floor.physicsBody?.allowsRotation = false
                floor.physicsBody?.usesPreciseCollisionDetection = true
                floor.physicsBody?.friction = 0
                floor.physicsBody?.restitution = 0
                floor.physicsBody?.categoryBitMask = categoryMask.floor.rawValue
                floor.physicsBody?.collisionBitMask = categoryMask.player.rawValue
                floor.physicsBody?.contactTestBitMask =  categoryMask.player.rawValue
                floor.physicsBody?.density = 100
            }
        }
        
        enumerateChildNodes(withName: "//Mountain") {
            node, stop in
            if let mountain = node as? SKSpriteNode {
                mountain.physicsBody = .init(rectangleOf: mountain.size)
                mountain.physicsBody?.isDynamic = false
                mountain.physicsBody?.affectedByGravity = false
                mountain.physicsBody?.allowsRotation = false
                mountain.physicsBody?.usesPreciseCollisionDetection = true
                mountain.physicsBody?.categoryBitMask = categoryMask.wall.rawValue
                mountain.physicsBody?.collisionBitMask = categoryMask.player.rawValue
                mountain.physicsBody?.contactTestBitMask = categoryMask.player.rawValue
            }
        }
        
        timeRift = childNode(withName: "//TimeRift") as? SKSpriteNode

        player = Player(level: "Reverse", frame: frame)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = categoryMask.player.rawValue
        player.physicsBody?.collisionBitMask = 0x0000001E
        player.physicsBody?.contactTestBitMask = categoryMask.spade.rawValue | categoryMask.goal.rawValue | categoryMask.wall.rawValue
        addChild(player)

        rotatePlatform = childNode(withName: "//RotatePlatform") as? SKSpriteNode
        rotatePlatform.run(.repeatForever(rotatePlatformActionSequence))
        
        key = childNode(withName: "//Key") as? SKSpriteNode
        
        cameraNode = SKCameraNode()
        let x = (size.width / 2) - (view.bounds.width / 2)
        cameraNode.position = .init(x: x, y: frame.midY)
        camera = cameraNode
        addChild(cameraNode)
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if let name = contact.bodyA.node?.name {
            if name == "Key" && player.getKey == false {
                player.getKey = true
                key.isHidden = true
                player.duringAnimation = true
                let moveCamera = SKAction.moveTo(x: -1536, duration: 2)
                cameraNode.run(moveCamera)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let fadeInTimeRift = SKAction.fadeIn(withDuration: 1)
                    self.timeRift.run(fadeInTimeRift)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let returnCamera = SKAction.moveTo(x: self.player.position.x, duration: 2)
                        self.cameraNode.run(returnCamera)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.player.duringAnimation = false
                        }
                    }
                }
            } else if name == "TimeRift" && player.getKey == true {
                let newScene = HistoryScene(level: "Normal", lang: self.lang!)
                self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
            } else if name == "Spade" {
                if player.numberOfLife - 1 == 0 {
                    let newScene = GameOver(level: "Reverse", lang: self.lang!)
                    self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
                } else {
                    let heart = childNode(withName: "//Heart\(player.numberOfLife)") as! SKSpriteNode
                    player.numberOfLife -= 1
                    heart.isHidden = true
                }
            } else if name == "Wall" && contact.bodyB.node?.name == "Meep" {
                if contact.bodyA.node!.position.x > contact.bodyB.node!.position.x {
                    player.moveBackOn = false
                } else if contact.bodyA.node!.position.x < contact.bodyB.node!.position.x {
                    player.runOn = false
                }
                self.cameraMove = false
                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else if name == "Floor" || name == "Mountain" || name == "FlyingPlatform" {
                self.cameraMove = true
                player.moveBackOn = true
                player.runOn = true
                player.numberOfJump = 0
            }
        }
    }
        
    
    public func didEnd(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Wall" && contact.bodyB.node?.name == "Meep" {
            self.cameraMove = true
            player.moveBackOn = true
            player.runOn = true
        }
    }
    
    func rotatePlatformAction() -> SKAction {
        let rotateValue: CGFloat = .pi / 2
        return SKAction.run {
            let rotateAction = SKAction.rotate(byAngle: rotateValue, duration: 1)
            self.rotatePlatform.run(rotateAction)
        }
    }
    
    func flying(platform: SKSpriteNode) {
        let upValue: CGFloat = 240
        let flyDown = SKAction.moveTo(y: platform.position.y, duration: 1)
        let flyUp = SKAction.moveTo(y: platform.position.y - upValue, duration: 1)
        let flyingActionSequence = SKAction.sequence([flyDown, .wait(forDuration: 3), flyUp, .wait(forDuration: 3)])
        platform.run(.repeatForever(flyingActionSequence))
    }
    
    func moveHeart() {
        let heart1 = childNode(withName: "//Heart1") as! SKSpriteNode
        let heart2 = childNode(withName: "//Heart2") as! SKSpriteNode
        let heart3 = childNode(withName: "//Heart3") as! SKSpriteNode
        if heart1.isHidden == false {
            heart1.position.x = (cameraNode.position.x + 512 - 118)
        }
        if heart2.isHidden == false {
            heart2.position.x = heart1.position.x - 90
        }
        if heart3.isHidden == false {
            heart3.position.x = heart2.position.x - 90
        }
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.leftArrow.rawValue:
            player.runPlayer()
        case macOSKeyMap.rightArrow.rawValue:
            player.moveBackPlayer()
        case macOSKeyMap.downArrow.rawValue:
            player.jumpPlayer()
        case macOSKeyMap.upArrow.rawValue:
            player.squattingPlayer()
        case macOSKeyMap.touchZ.rawValue:
            player.diagonalJump(direction: "Left")
        case macOSKeyMap.touchX.rawValue:
            player.diagonalJump(direction: "Right")
        default:
            return
        }
    }
    
    public override func keyUp(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.upArrow.rawValue:
            player.noSquattingPlayer()
        default:
            return
        }
    }
    
    func scrollBackground() {
        enumerateChildNodes(withName: "//Cloud") {
            node, stop in
            if let cloud = node as? SKSpriteNode {
                cloud.position.x += 5
                if cloud.position.x > (self.size.width / 2 + 200) {
                    cloud.position.x = -(self.size.width / 2 + 200)
                }
            }
         }
    }

    
    public override func update(_ currentTime: TimeInterval) {
        self.scrollBackground()
        player.physicsBody?.velocity.dx = 0
        if  player.position.x > -1536 && player.position.x < cameraNode.position.x && cameraMove == true {
            cameraNode.position = .init(x: player.position.x, y: 0)
            moveHeart()
        }
        else if player.position.x < 1536 && player.position.x > cameraNode.position.x && cameraMove == true {
            cameraNode.position = .init(x: player.position.x, y: 0)
            moveHeart()
        }
    }
    
}

