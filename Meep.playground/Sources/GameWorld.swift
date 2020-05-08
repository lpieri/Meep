import SpriteKit

public class GameScene: SKScene {

    public override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
    }
    
    @objc static public override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
//        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
//
//        n.position = pos
//        n.strokeColor = SKColor.green
//        addChild(n)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        guard let n = self.spinnyNode.copy() as? SKShapeNode else { return }
//
//        n.position = pos
//        n.strokeColor = SKColor.blue
//        addChild(n)
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        guard let n = spinnyNode.copy() as? SKShapeNode else { return }
//
//        n.position = pos
//        n.strokeColor = SKColor.red
//        addChild(n)
    }
    
    public override func mouseDown(with event: NSEvent) {
        touchDown(atPoint: event.location(in: self))
    }
    
    public override func mouseDragged(with event: NSEvent) {
        touchMoved(toPoint: event.location(in: self))
    }
    
    public override func mouseUp(with event: NSEvent) {
        touchUp(atPoint: event.location(in: self))
    }
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
