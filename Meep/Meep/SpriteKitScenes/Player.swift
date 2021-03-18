//
//  Player.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SpriteKit

public class Player: SKSpriteNode {
    
    private let levelTexture: String
    public let runValue: CGFloat
    private let moveBackValue: CGFloat
    private let jumpValue: CGFloat
    public var numberOfJump: Int
    public var getKey: Bool
    public var duringAnimation: Bool
    public var runOn: Bool
    public var moveBackOn: Bool
    public var numberOfLife: Int
    public let parentFrame: CGRect
    
    public init(level: String, frame: CGRect) {
        self.parentFrame = frame
        self.levelTexture = level
        self.runValue = level == "Reverse" ? -25 : 25
        self.moveBackValue = self.runValue * -1
        self.jumpValue = level == "Reverse" ? -90 : 90
        self.numberOfJump = 0
        self.numberOfLife = 3
        self.getKey = false
        self.duringAnimation = false
        self.runOn = true
        self.moveBackOn = true
        var position: CGPoint
        var rotate: CGFloat = 0
        if level == "Level0" {
            position = CGPoint(x: 1980, y: -291)
        }
        if level == "Reverse" {
            position = CGPoint(x: 1980, y: 291)
            rotate = .pi / 1
        } else {
            position = CGPoint(x: -1980, y: -291)
        }
        let texture = SKTexture(imageNamed: "Meep-Bleu-1")
        super.init(texture: texture, color: .clear, size: texture.size())
//        self.xScale = 1
//        self.yScale = 1
        self.position = position
        self.zRotation = rotate
        self.name = "Meep"
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func runPlayer() {
        self.position.x += self.runValue
//        if self.duringAnimation == false {
//            if runOn == true {
//                if levelTexture == "Reverse" {
//                    if self.position.x + self.runValue > self.parentFrame.minX {
//                        self.position.x += self.runValue
//                    }
//                } else if levelTexture == "Normal" {
//                    if self.position.x + self.runValue < self.parentFrame.maxX {
//                        self.position.x += self.runValue
//                    }
//                }
//            }
//        }
    }

    public func moveBackPlayer() {
        self.position.x += self.moveBackValue
//        if self.duringAnimation == false {
//            if moveBackOn == true {
//                if levelTexture == "Reverse" {
//                    if self.position.x + self.moveBackValue < self.parentFrame.maxX {
//                        self.position.x += self.moveBackValue
//                    }
//                } else if levelTexture == "Normal" {
//                    if self.position.x + self.moveBackValue > self.parentFrame.minX {
//                        self.position.x += self.moveBackValue
//                    }
//                }
//            }
//        }
    }
    
    public func diagonalJump(direction: String) {
        if self.numberOfJump < 2 && self.duringAnimation == false {
            self.position.y += jumpValue
            if levelTexture == "Reverse" {
                if self.position.x + self.runValue > self.parentFrame.minX && direction == "Left" {
                    self.position.x += self.runValue
                } else if self.position.x + self.moveBackValue < self.parentFrame.maxX && direction == "Right" {
                    self.position.x += self.moveBackValue
                }
            } else if levelTexture == "Normal" {
                if self.position.x + self.moveBackValue > self.parentFrame.minX && direction == "Left" {
                    self.position.x += self.moveBackValue
                } else if self.position.x + self.runValue < self.parentFrame.maxX && direction == "Right" {
                    self.position.x += self.runValue
                }
            }
            self.numberOfJump += 1
        }
    }
    
    public func jumpPlayer() {
        if self.numberOfJump < 2 && self.duringAnimation == false {
            self.position.y += jumpValue
            self.numberOfJump += 1
        }
    }

    public func squattingPlayer() {
        self.texture = SKTexture(imageNamed: "textureSquattingReversePlayer")
        self.yScale = 1
    }
    
    public func noSquattingPlayer() {
        self.texture = SKTexture(imageNamed: "Meep-Bleu-1")
    }
    
}

