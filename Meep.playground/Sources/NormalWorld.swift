import SpriteKit

public class NormalWorld: SKScene {
    
    public var  normalPlayer: SKSpriteNode!
    
    public override func didMove(to view: SKView) {
        normalPlayer = childNode(withName: "//NormalPlayer") as? SKSpriteNode
    }
    
    public override func update(_ currentTime: TimeInterval) {}
    
}
