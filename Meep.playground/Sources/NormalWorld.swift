import SpriteKit

public class NormalWorld: SKScene, SKPhysicsContactDelegate {

    public var cameraNode: SKCameraNode!
    public var player: Player!
    
    public override func didMove(to view: SKView) {
        
        self.size = CGSize(width: 4096, height: 768)
        self.scaleMode = .aspectFill
        self.physicsWorld.contactDelegate = self
        
        print(frame)
        
        player = Player(level: "Normal", frame: frame)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = 15
        addChild(player)
        print(player.position)
        
        cameraNode = SKCameraNode()
        let x = ((size.width / 2) * -1) + (view.bounds.width / 2)
        cameraNode.position = .init(x: x, y: frame.midY)
        camera = cameraNode
        addChild(cameraNode)
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {}
    
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
