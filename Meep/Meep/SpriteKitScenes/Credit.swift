//
//  Credit.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SpriteKit

public class Credits: SKScene {
    
    private var heart1: SKSpriteNode
    private var heart2: SKSpriteNode
    
    public override init() {
        self.heart1 = SKSpriteNode(imageNamed: "textureHeart")
        self.heart2 = SKSpriteNode(imageNamed: "textureHeart")
        let tree = SKSpriteNode(imageNamed: "textureNormalTree")
        let logo = SKSpriteNode(imageNamed: "textureCredits")
        let floor = SKSpriteNode(imageNamed: "textureFloor")
        let player = SKSpriteNode(imageNamed: "textureNormalPlayer")
        super.init(size: CGSize(width: 1024, height: 768))
        logo.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        floor.yScale = 2
        floor.position = CGPoint(x: self.size.width / 2, y: 0 + (floor.size.height / 2))
        player.xScale = 2
        player.yScale = 2
        player.position = CGPoint(x: self.size.width - 200, y: floor.position.y + (floor.size.height / 2) + (player.size.height / 2))
        tree.xScale = 2
        tree.yScale = 2
        tree.position = CGPoint(x: self.size.width - 100, y: floor.position.y + (floor.size.height / 2) + (tree.size.height / 2))
        self.heart1.xScale = 0.5
        self.heart1.yScale = 0.5
        self.heart1.zRotation = (.pi / 4) * -1
        self.heart1.position = CGPoint(x: self.size.width - 175, y: player.position.y + (player.size.height / 2) + 20)
        self.heart2.xScale = 0.5
        self.heart2.yScale = 0.5
        self.heart2.zRotation = .pi / 4
        self.heart2.position = CGPoint(x: self.size.width - 225, y: player.position.y + (player.size.height / 2) + 20)
        self.addChild(logo)
        self.addChild(floor)
        self.addChild(player)
        self.addChild(tree)
        self.addChild(self.heart1)
        self.addChild(self.heart2)
    }
    
    public override func didMove(to view: SKView) {
        let heart1Move = SKAction.sequence([.move(to: CGPoint(x: self.heart1.position.x + 10, y: self.heart1.position.y + 10), duration: 1),
                                            .wait(forDuration: 1),
                                            .move(to: self.heart1.position, duration: 1),
                                            .wait(forDuration: 1)])
        self.heart1.run(.repeatForever(heart1Move))
        let heart2Move = SKAction.sequence([.move(to: CGPoint(x: self.heart2.position.x - 10, y: self.heart2.position.y + 10), duration: 1),
                                            .wait(forDuration: 1),
                                            .move(to: self.heart2.position, duration: 1),
                                            .wait(forDuration: 1)])
        self.heart2.run(.repeatForever(heart2Move))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

