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
    
    public var background: SKSpriteNode!
    public var levelReference: SKReferenceNode!
    public var cameraNode: SKCameraNode!
    public var levelName: String!
    public var player: SKSpriteNode!
    
    public override func didMove(to view: SKView) {

        player = childNode(withName: "//Meep") as? SKSpriteNode
        
        cameraNode = SKCameraNode()
        let x = (size.width / 2) - (view.bounds.width / 2)
        cameraNode.position = .init(x: x, y: frame.midY)
        camera = cameraNode
        addChild(cameraNode)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func runPlayer(level: String) {
        let xAddValue: CGFloat = level == "Reverse" ? -30 : 30
        if player.position.x + xAddValue > cameraNode.position.x - 512 {
            player.position.x += xAddValue
        }
    }

    func moveBackPlayer(level: String) {
        let xAddValue: CGFloat = level == "Reverse" ? 30 : -30
        if player.position.x + xAddValue < cameraNode.position.x + 512 {
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
        if player.position.x < cameraNode.position.x {
            if player.position.x > -1536 {
                cameraNode.position = .init(x: player.position.x, y: 0)
            }
        }
        
    }
}

let Width = 1024
let Height = 768

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: Width, height: Height))
if let scene = GameWorld(fileNamed: "levelReverse") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
