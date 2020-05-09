//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

public class GameWorld: SKScene {
    
    enum macOSKeyMap: UInt16 {
        case leftArrow = 123
        case rightArrow = 124
        case upArrow = 126
        case downArrow = 125
    }
    
    public var levelReference: SKReferenceNode!
    public var cameraNode: SKCameraNode!
    public var levelName: String!
    public var player: SKSpriteNode!
    
    public override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 9)
        
        let background = SKSpriteNode(imageNamed: "textureReverseSky")
        background.position = .init(x: frame.midX, y: frame.midY)
        background.xScale = 3
        background.yScale = 6
        background.zPosition = -1
        addChild(background)
        
        let floor = SKSpriteNode(imageNamed: "textureFloor")
        floor.name = "Floor"
        floor.position = .init(x: 0, y: frame.maxY)
        floor.xScale = 3
        floor.yScale = 3
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.allowsRotation = false
        addChild(floor)

        player = SKSpriteNode(imageNamed: "textureReversePlayer")
        player.name = "Meep"
        player.position = .init(x: frame.midX, y: frame.midY)
        player.zRotation = .pi / 1
        player.xScale = 2
        player.yScale = 2
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = false
        addChild(player)

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func runPlayer(level: String) {
        let xAddValue: CGFloat = level == "Reverse" ? -30 : 30
        if player.position.x + xAddValue > frame.minX {
            player.position.x += xAddValue
        }
    }

    func moveBackPlayer(level: String) {
        let xAddValue: CGFloat = level == "Reverse" ? 30 : -30
        if player.position.x + xAddValue < frame.maxX {
            player.position.x += xAddValue
        }
    }
    
    func jumpPlayer(level: String) {
        let yAddValue: CGFloat = level == "Reverse" ? -30 : 30
        player.position.y += yAddValue
    }

    func squattingPlayer(level: String) {
        player.texture = SKTexture(imageNamed: "textureSquattingReversePlayer")
        player.yScale = 1
    }
    
    func noSquattingPlayer(level: String) {
        player.texture = SKTexture(imageNamed: "textureReversePlayer")
        player.yScale = 2
    }
    
    #if os(macOS)
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.leftArrow.rawValue:
            runPlayer(level: "Reverse")
        case macOSKeyMap.rightArrow.rawValue:
            moveBackPlayer(level: "Reverse")
        case macOSKeyMap.downArrow.rawValue:
            jumpPlayer(level: "Reverse")
        case macOSKeyMap.upArrow.rawValue:
            squattingPlayer(level: "Reverse")
        default:
            return
        }
    }
    
    public override func keyUp(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.upArrow.rawValue:
            noSquattingPlayer(level: "Reverse")
        default:
            return
        }
    }
    #endif
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//        cameraNode.position = .init(x: player.position.x, y: player.position.y)
    }
}

let Width = 1024
let Height = 768

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: Width, height: Height))
if let scene = GameWorld(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
