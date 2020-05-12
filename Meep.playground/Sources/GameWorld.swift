import SpriteKit

let historyText = """
Meep is a little blue monster,
he lives in a universe where all monsters are blue,
but Meep is not a monster like the others...

Meep is a transgender monster...
She dreams of becoming a pink monster in the other universe.
"""

public class GameWorld: SKScene {
    
    enum macOSKeyMap: UInt16 {
        case leftArrow = 123
        case rightArrow = 124
        case upArrow = 126
        case downArrow = 125
    }
    
    public var rotatePlatform: SKSpriteNode!
    public var cameraNode: SKCameraNode!
    public var player: Player!
    
    func writingHistory() -> SKAction {
        return SKAction.run {
            let text = SKLabelNode(text: historyText)
            text.lineBreakMode = .byCharWrapping
            text.numberOfLines = 3
            text.color = .white
            text.alpha = 0.0
            text.fontSize = 21
            text.position = .init(x: self.frame.maxX - 265, y: self.frame.minY + 100)
            let appear = SKAction.fadeIn(withDuration: 1)
            let disappear = SKAction.fadeOut(withDuration: 1)
            let textPrintActionSequence = SKAction.sequence([appear, .wait(forDuration: 10), disappear])
            self.addChild(text)
            text.run(textPrintActionSequence)
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
    
    public override func didMove(to view: SKView) {
        
        self.size = CGSize(width: 4096, height: 768)
        self.scaleMode = .aspectFill
        
        let rotatePlatformActionSequence = SKAction.sequence([rotatePlatformAction(), .wait(forDuration: 2), rotatePlatformAction(), .wait(forDuration: 2)])

        enumerateChildNodes(withName: "//FlyingPlatform") {
            node, stop in
            if let platform = node as? SKSpriteNode {
                self.flying(platform: platform)
            }
        }
        
        self.run(writingHistory())
        player = Player(level: "Reverse", frame: frame)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        addChild(player)
        rotatePlatform = childNode(withName: "//RotatePlatform") as? SKSpriteNode
        rotatePlatform.run(.repeatForever(rotatePlatformActionSequence))
        
        print(frame)
        print(view.bounds)
        print(self.size)
        cameraNode = SKCameraNode()
        let x = (size.width / 2) - (view.bounds.width / 2)
        cameraNode.position = .init(x: x, y: frame.midY)
        camera = cameraNode
        addChild(cameraNode)
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
