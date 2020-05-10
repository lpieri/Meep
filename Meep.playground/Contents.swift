//: A SpriteKit based Playground

import PlaygroundSupport
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
    public var flyingPlatform: SKSpriteNode!
    public var cameraNode: SKCameraNode!
    public var player: SKSpriteNode!
    
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
    
    func flyingPlatformAction(direction: String) -> SKAction {
        let upValue: CGFloat = 240
        return SKAction.run {
            if direction == "down" {
                let move = SKAction.moveTo(y: self.flyingPlatform.position.y - upValue, duration: 1)
                self.flyingPlatform.run(move)
            } else {
                let move = SKAction.moveTo(y: self.flyingPlatform.position.y + upValue, duration: 1)
                self.flyingPlatform.run(move)
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
    
    public override func didMove(to view: SKView) {

        let flyingPlatformActionSequence = SKAction.sequence([flyingPlatformAction(direction: "down"), .wait(forDuration: 3), flyingPlatformAction(direction: "up"), .wait(forDuration: 3)])
        
        let rotatePlatformActionSequence = SKAction.sequence([rotatePlatformAction(), .wait(forDuration: 2), rotatePlatformAction(), .wait(forDuration: 2)])
        
        self.run(writingHistory())
        player = childNode(withName: "//Meep") as? SKSpriteNode
        rotatePlatform = childNode(withName: "//RotatePlatform") as? SKSpriteNode
        flyingPlatform = childNode(withName: "//FlyingPlatform") as? SKSpriteNode
        
        flyingPlatform.run(.repeatForever(flyingPlatformActionSequence))
        rotatePlatform.run(.repeatForever(rotatePlatformActionSequence))
        
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
        let yAddValue: CGFloat = level == "Reverse" ? -50 : 50
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
