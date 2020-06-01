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
        var rotate: CGFloat
        if level == "Reverse" {
            position = CGPoint(x: 1980, y: 291)
            rotate = .pi / 1
        } else {
            rotate = 0
            position = CGPoint(x: -1980, y: -291)
        }
        super.init(texture: SKTexture(imageNamed: "textureReversePlayer"), color: .clear, size: CGSize(width: 20, height: 29))
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
        if self.duringAnimation == false {
            if runOn == true {
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
        }
    }

    public func moveBackPlayer() {
        if self.duringAnimation == false {
            if moveBackOn == true {
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
        }
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
        self.texture = SKTexture(imageNamed: "textureReversePlayer")
        self.yScale = 2
    }
    
}

