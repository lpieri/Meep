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
    
    public let macOSKeyToFunc: [UInt16:(String) -> Void] = []
    
    public var levelReference: SKReferenceNode!
    public var levelName: String!
    public var player: SKSpriteNode!
    
    public override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        
        levelReference = childNode(withName: "//LevelReference") as? SKReferenceNode
        levelName = "Reverse"
        levelReference.resolve()
        player = childNode(withName: "//Meep") as? SKSpriteNode
        print(player)
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
        player.position.x += xAddValue
    }
    
    #if os(macOS)
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.leftArrow.rawValue:
            runPlayer(level: "Reverse")
        default:
            print(key)
        }
    }
    #endif
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
