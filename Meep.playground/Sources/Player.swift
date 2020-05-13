import SpriteKit

public class Player: SKSpriteNode {
    
    private let levelTexture: String
    private let runValue: CGFloat
    private let moveBackValue: CGFloat
    private let jumpValue: CGFloat
    private var numberOfJump: Int
    public var numberOfLife: Int
    public var getKey: Bool
    public let parentFrame: CGRect
    
    public init(level: String, frame: CGRect) {
        self.parentFrame = frame
        self.levelTexture = level
        self.runValue = level == "Reverse" ? -30 : 30
        self.moveBackValue = self.runValue * -1
        self.jumpValue = level == "Reverse" ? -60 : 60
        self.numberOfJump = 0
        self.numberOfLife = 3
        self.getKey = false
        let xPosition = 1980
        var texture: SKTexture
        var position: CGPoint
        var rotate: CGFloat
        if level == "Reverse" {
            position = CGPoint(x: xPosition, y: 291)
            rotate = .pi / 1
            texture = SKTexture(imageNamed: "texture\(self.levelTexture)Player")
        } else {
            rotate = 0
            position = CGPoint(x: xPosition * -1, y: -291)
            texture = SKTexture(imageNamed: "texture\(self.levelTexture)Player")
        }
        super.init(texture: texture, color: .clear, size: CGSize(width: 20, height: 29))
        self.xScale = 2
        self.yScale = 2
        self.position = position
        self.zRotation = rotate
        self.name = "Meep"
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func runPlayer() {
        if levelTexture == "Reverse" {
            if self.position.x + self.runValue > self.parentFrame.minX {
                self.position.x += self.runValue
            }
        } else if levelTexture == "Normal" {
            if self.position.x + self.runValue < self.parentFrame.maxX {
                self.position.x += self.runValue
            }
        }
        
    }

    public func moveBackPlayer() {
        if levelTexture == "Reverse" {
            if self.position.x + self.moveBackValue < self.parentFrame.maxX {
                self.position.x += self.moveBackValue
            }
        } else if levelTexture == "Normal" {
            if self.position.x + self.moveBackValue > self.parentFrame.minX {
                self.position.x += self.moveBackValue
            }
        }
    }
    
    public func jumpPlayer() {
        if self.numberOfJump < 2 {
            self.position.y += jumpValue
            self.numberOfJump += 1
        }
    }
    
    public func falloffPlayer() {
        self.numberOfJump -= 1
    }

    public func squattingPlayer() {
        self.texture = SKTexture(imageNamed: "textureSquatting\(self.levelTexture)Player")
        self.yScale = 1
    }
    
    public func noSquattingPlayer() {
        self.texture = SKTexture(imageNamed: "texture\(self.levelTexture)Player")
        self.yScale = 2
    }
    
}
