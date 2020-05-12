import SpriteKit

public class StartGame: SKScene {
    
    private let startMessage: String
    private let label: SKLabelNode
    
    public override init() {
        #if os(macOS)
        startMessage = "Press space to start..."
        #elseif os(iOS)
        startMessage = "Touch the screen to start..."
        #endif
        let size = CGSize(width: 4096, height: 768)
        self.label = SKLabelNode(text: self.startMessage)
        let logo = SKSpriteNode(imageNamed: "textureLogo")
        super.init(size: size)
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
        print(frame)
        print(view.bounds)
        print(self.size)
    }
    
    public func changeScene(level: String) {
        let gameScene = GameWorld(fileNamed: "levelReverse")
        self.scene?.view?.presentScene(gameScene!, transition: .fade(withDuration: 1))
    }
    
    #if os(macOS)
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case 49:
            self.changeScene(level: "Reverse")
        default:
            print(key)
        }
    }
    #elseif os(iOS)
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.changeScene(level: "Reverse")
    }
    #endif
    
}
