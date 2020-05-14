import SpriteKit

public class ReverseWorld: SKScene, SKPhysicsContactDelegate {

    public var normalTree: SKSpriteNode!
    public var key: SKSpriteNode!
    public var rotatePlatform: SKSpriteNode!
    public var cameraNode: SKCameraNode!
    public var player: Player!
    private var previousPlayerPositionX: CGFloat!
    
    public override func didMove(to view: SKView) {
        
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
                platform.physicsBody?.categoryBitMask = categoryMask.wall.rawValue
                platform.physicsBody?.collisionBitMask = categoryMask.player.rawValue
                platform.physicsBody?.contactTestBitMask = 0x00000000
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
                wall.physicsBody?.categoryBitMask = categoryMask.wall.rawValue
                wall.physicsBody?.collisionBitMask = categoryMask.player.rawValue
                wall.physicsBody?.contactTestBitMask = 0x00000000
                wall.physicsBody?.density = 100
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
                mountain.physicsBody?.contactTestBitMask = 0x00000000
                mountain.physicsBody?.density = 100
            }
        }
        
        normalTree = childNode(withName: "//NormalTree") as? SKSpriteNode

        player = Player(level: "Reverse", frame: frame)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = categoryMask.player.rawValue
        player.physicsBody?.collisionBitMask = 0x0000001E
        player.physicsBody?.contactTestBitMask = categoryMask.spade.rawValue | categoryMask.goal.rawValue
        addChild(player)
        
        previousPlayerPositionX = player.position.x

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
            if name == "Key" {
                player.getKey = true
                key.isHidden = true
                player.duringAnimation = true
                let moveCamera = SKAction.sequence([.moveTo(x: -1536, duration: 2.5), .moveTo(x: cameraNode.position.x, duration: 2.5)])
                cameraNode.run(moveCamera)
                player.duringAnimation = false
            } else if name == "NormalTree" && player.getKey == true {
                let newScene = HistoryScene(level: "Normal")
                self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
            } else if name == "Spade" {
                if player.numberOfLife - 1 == 0 {
                    let newScene = GameOver(level: "Reverse")
                    self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
                } else {
                    let heart = childNode(withName: "//Heart\(player.numberOfLife)") as! SKSpriteNode
                    player.numberOfLife -= 1
                    heart.isHidden = true
                }
            }
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
    
    #if os(macOS)
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
        default:
            return
        }
    }
    
    public override func keyUp(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.upArrow.rawValue:
            player.noSquattingPlayer()
        case macOSKeyMap.downArrow.rawValue:
            player.falloffPlayer()
        default:
            return
        }
    }
    #endif
    
    public override func update(_ currentTime: TimeInterval) {
        if player.position.x - previousPlayerPositionX < -27 {
            if  player.position.x > -1536 && player.position.x < cameraNode.position.x {
                previousPlayerPositionX = player.position.x
                cameraNode.position = .init(x: player.position.x, y: 0)
                moveHeart()
            }
        } else if player.position.x - previousPlayerPositionX > 27 {
            if player.position.x < 1536 && player.position.x > cameraNode.position.x {
                previousPlayerPositionX = player.position.x
                cameraNode.position = .init(x: player.position.x, y: 0)
                moveHeart()
            }
        }
    }
    
}
