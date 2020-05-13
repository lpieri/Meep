import SpriteKit

public class NormalWorld: SKScene, SKPhysicsContactDelegate {

    public var door: SKSpriteNode!
    public var cameraNode: SKCameraNode!
    public var player: Player!
    
    public override func didMove(to view: SKView) {
        
        self.size = CGSize(width: 4096, height: 768)
        self.scaleMode = .aspectFill
        self.physicsWorld.contactDelegate = self
        
        enumerateChildNodes(withName: "//RotatePlatform") {
            node, stop in
            if let platform = node as? SKSpriteNode {
                self.rotate(platform: platform)
            }
        }
        
        enumerateChildNodes(withName: "//FlyingPlatformDown") {
            node, stop in
            if let platform = node as? SKSpriteNode {
                self.flying(platform: platform, direction: "Down")
            }
        }
        
        enumerateChildNodes(withName: "//FlyingPlatformUp") {
            node, stop in
            if let platform = node as? SKSpriteNode {
                self.flying(platform: platform, direction: "Up")
            }
        }

        
        door = childNode(withName: "//Door") as? SKSpriteNode
        
        player = Player(level: "Normal", frame: frame)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = 15
        addChild(player)
        
        cameraNode = SKCameraNode()
        let x = ((size.width / 2) * -1) + (view.bounds.width / 2)
        cameraNode.position = .init(x: x, y: frame.midY)
        camera = cameraNode
        addChild(cameraNode)
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if let name = contact.bodyA.node?.name {
            if name == "Spade" {
                if player.numberOfLife - 1 == 0 {
                    let newScene = GameOver()
                    self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
                } else {
                    player.numberOfLife -= 1
                }
            } else if name == "Button" {
                player.duringAnimation = true
                let moveCamera = SKAction.moveTo(x: door.position.x, duration: 0.5)
                cameraNode.run(moveCamera)
                let openDoor = SKAction.moveTo(y: door.position.y + 41, duration: 1)
                door.run(openDoor)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let returnCamera = SKAction.moveTo(x: 1536, duration: 0.5)
                    self.cameraNode.run(returnCamera)
                    self.player.duringAnimation = false
                }
            }
        }
    }
    
    func rotate(platform: SKSpriteNode) {
        let rotateValue: CGFloat = .pi / 2
        let rotateAction = SKAction.rotate(byAngle: rotateValue, duration: 1)
        let rotateActionSequence = SKAction.sequence([rotateAction, .wait(forDuration: 2), rotateAction, .wait(forDuration: 2)])
        platform.run(.repeatForever(rotateActionSequence))
    }
    
    func flying(platform: SKSpriteNode, direction: String) {
        let upValue: CGFloat = 240
        let returnPos = SKAction.moveTo(y: platform.position.y, duration: 1)
        let flyDown = SKAction.moveTo(y: platform.position.y - upValue, duration: 1)
        let flyUp = SKAction.moveTo(y: platform.position.y + upValue, duration: 1)
        var flyingActionSequence: SKAction
        if direction == "Up" {
            flyingActionSequence = SKAction.sequence([flyUp, .wait(forDuration: 3), returnPos, .wait(forDuration: 3)])
        } else {
            flyingActionSequence = SKAction.sequence([flyDown, .wait(forDuration: 3), returnPos, .wait(forDuration: 3)])
        }
        platform.run(.repeatForever(flyingActionSequence))
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    #if os(macOS)
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.leftArrow.rawValue:
            player.moveBackPlayer()
        case macOSKeyMap.rightArrow.rawValue:
            player.runPlayer()
        case macOSKeyMap.downArrow.rawValue:
            player.squattingPlayer()
        case macOSKeyMap.upArrow.rawValue:
            player.jumpPlayer()
        default:
            return
        }
    }
    
    public override func keyUp(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.upArrow.rawValue:
            player.falloffPlayer()
        case macOSKeyMap.downArrow.rawValue:
            player.noSquattingPlayer()
        default:
            return
        }
    }
    #endif
    
    public override func update(_ currentTime: TimeInterval) {
        if player.position.x < cameraNode.position.x {
            if player.position.x > -1536 {
                cameraNode.position = .init(x: player.position.x, y: 0)
            }
        } else if player.position.x > cameraNode.position.x {
            if player.position.x < 1536 {
                cameraNode.position = .init(x: player.position.x, y: 0)
            }
        }
    }
}
