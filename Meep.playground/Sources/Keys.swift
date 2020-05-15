import SpriteKit

public class KeysScene: SKScene {
    
    private let message: String
    private let currentLevel: String
    private let label: SKLabelNode
    
    public init(level: String) {
        message = "Press space to continue..."
        self.currentLevel = level
        self.label = SKLabelNode(text: self.message)
        var keyImg: String
        if level == "Reverse" {
            keyImg = "textureKeysReverse"
        } else {
            keyImg = "textureKeysNormal"
        }
        let logo = SKSpriteNode(imageNamed: keyImg)
        super.init(size: CGSize(width: 1024, height: 768))
        logo.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 300)
        self.label.alpha = 0
        self.addChild(logo)
        self.addChild(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        let labelActionSequence = SKAction.sequence([.fadeIn(withDuration: 1), .fadeOut(withDuration: 1)])
        self.label.run(.repeatForever(labelActionSequence))
    }
    
    public func changeScene(level: String) {
           var newScene: SKScene
           if currentLevel == "Reverse" {
               newScene = ReverseWorld(fileNamed: "levelReverse")!
           } else {
               newScene = NormalWorld(fileNamed: "levelNormal")!
           }
           self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
       }
    
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.space.rawValue:
            self.changeScene(level: "Reverse")
        default:
            return
        }
    }

}
