//
//  Level0.swift
//  Meep
//
//  Created by Louise on 18/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SpriteKit

public class Level0: SKScene, SKPhysicsContactDelegate {
    
    private var cameraNode: SKCameraNode!
    public var cameraMove: Bool!
    public var lang: String?
    private var mapping: MenuClass.Mapping?
    private var player: Player!
    
    convenience init?(fileNamed: String, lang: String, mapping: MenuClass.Mapping) {
        self.init(fileNamed: fileNamed)
        self.lang = lang
        self.mapping = mapping
    }
    
    public override func didMove(to view: SKView) {
        self.size = CGSize(width: 16384, height: 768)
        self.cameraMove = true
        
        player = Player(level: "Level0", frame: frame)
        player.position.x = (size.width / 2) - (view.bounds.width / 2)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = categoryMask.player.rawValue
        player.physicsBody?.collisionBitMask = 0x0000001E
        player.physicsBody?.contactTestBitMask = categoryMask.spade.rawValue | categoryMask.goal.rawValue | categoryMask.wall.rawValue
        addChild(player)
        
        
        cameraNode = SKCameraNode()
        cameraNode.xScale = 0.0625
        cameraNode.position = .init(x: (size.width / 2) - (view.bounds.width / 2), y: frame.midY)
        camera = cameraNode
        addChild(cameraNode)
    }
    
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case mapping?.runLeft:
            player.runPlayer()
        case mapping?.runRight:
            player.moveBackPlayer()
        case mapping?.crouch:
            player.jumpPlayer()
        case mapping?.jump:
            player.squattingPlayer()
        case mapping?.diagJumpLeft:
            player.diagonalJump(direction: "Left")
        case mapping?.diagJumpRight:
            player.diagonalJump(direction: "Right")
        default:
            return
        }
    }
    
    public override func keyUp(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case mapping?.jump:
            player.noSquattingPlayer()
        default:
            return
        }
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
//        player.physicsBody?.velocity.dx = 0
        if  player.position.x > -8042 && player.position.x < cameraNode.position.x && cameraMove == true {
            cameraNode.position = .init(x: player.position.x, y: 0)
        }
        else if player.position.x < 8042 && player.position.x > cameraNode.position.x && cameraMove == true {
            cameraNode.position = .init(x: player.position.x, y: 0)
        }
    }
}
