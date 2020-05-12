import SpriteKit

let reverseLevelText = """
Meep is a little blue monster.
He lives in a universe where all monsters are blue,
but Meep is not a monster like the others...

Meep is a transgender monster...
She dreams of becoming a pink monster in the other universe.
She knows how to go to the other universe, where everything is upside down.

To get to the other universe, she has to cross a locked time rift.
"""

let normalLevelText = """
Meep found the temporal rift and arrived in the universe of the pink monsters.

But Meep's adventure had just begun...
Meep must now integrate into the world of the pink monsters.
For this, Meep will have to make a blend to become a pink monster too.
"""

public class HistoryScene: SKScene {

    private let currentLevel: String
    private let continueMessage: String
    private let label: SKLabelNode
    
    public init(level: String) {
        #if os(macOS)
        continueMessage = "Press space to continue..."
        #elseif os(iOS)
        continueMessage = "Touch the screen to continue..."
        #endif
        let size = CGSize(width: 1024, height: 768)
        self.currentLevel = level
        self.label = SKLabelNode(text: self.continueMessage)
        super.init(size: size)
        self.backgroundColor = .init(red: 64 / 255, green: 68 / 255, blue: 69 / 255, alpha: 1)
        self.scaleMode = .aspectFill
        self.label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 300)
        self.label.alpha = 0
        self.addChild(self.label)
        let historyText = (level == "Reverse") ? reverseLevelText : normalLevelText
        let historyLabel = SKLabelNode(text: historyText)
        historyLabel.lineBreakMode = .byCharWrapping
        historyLabel.numberOfLines = 9
        historyLabel.color = .white
        historyLabel.fontSize = 30
        historyLabel.position = .init(x: self.frame.midX, y: self.frame.midY)
        self.addChild(historyLabel)
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
    
    #if os(macOS)
    public override func keyDown(with event: NSEvent) {
        let key = event.keyCode
        switch key {
        case macOSKeyMap.space.rawValue:
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
