import SpriteKit

public class GameOver: SKScene {
    
    private let ghost: SKSpriteNode
    private let rip: SKSpriteNode
    private let label: SKLabelNode
    private let respawnMessage: String
    private let level: String
    
    public init(level: String) {
        self.respawnMessage = "Press space to respawn..."
        self.label = SKLabelNode(text: self.respawnMessage)
        let logo = SKSpriteNode(imageNamed: "textureGameOver")
        let floor = SKSpriteNode(imageNamed: "textureFloor")
        self.rip = SKSpriteNode(imageNamed: "textureRip")
        self.ghost = SKSpriteNode(imageNamed: "textureGhost")
        self.level = level
        super.init(size: CGSize(width: 1024, height: 768))
        self.label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 250)
        self.label.alpha = 0
        logo.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        floor.yScale = 2
        floor.position = CGPoint(x: self.size.width / 2, y: 0 + (floor.size.height / 2))
        self.rip.xScale = 2
        self.rip.yScale = 2
        self.rip.position = CGPoint(x: 200, y: floor.position.y + (floor.size.height / 2) + (rip.size.height / 2))
        self.ghost.xScale = 2
        self.ghost.yScale = 2
        self.ghost.position = CGPoint(x: self.rip.position.x, y: -30)
        self.addChild(logo)
        self.addChild(self.ghost)
        self.addChild(floor)
        self.addChild(self.rip)
        self.addChild(self.label)
    }
    
    public override func didMove(to view: SKView) {
        let labelActionSequence = SKAction.sequence([.fadeIn(withDuration: 1), .fadeOut(withDuration: 1)])
        self.label.run(.repeatForever(labelActionSequence))
        let ghostMove = SKAction.sequence([.moveTo(y: self.rip.position.y + 50, duration: 2),
                                           .wait(forDuration: 2),
                                           .move(to: self.ghost.position, duration: 2),
                                           .wait(forDuration: 2)])
        self.ghost.run(.repeatForever(ghostMove))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func changeScene() {
        let newScene = HistoryScene(level: self.level)
        self.scene?.view?.presentScene(newScene, transition: .fade(withDuration: 1))
    }
    
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.space.rawValue:
            self.changeScene()
        default:
            return
        }
    }
    
}
