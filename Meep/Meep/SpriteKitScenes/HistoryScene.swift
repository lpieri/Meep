//
//  HistoryScene.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SpriteKit

let reverseLevelTextEn = """
Meep is a little blue ghost.
He lives in a universe where all monsters are blue,
but Meep is not a monster like the others...

Meep is a transgender monster...
She dreams of becoming a pink monster in the other universe.
She knows how to go to the other universe, where everything is upside down.

To get to the other universe, she has to cross a locked time rift.
"""

let normalLevelTextEn = """
Meep found the temporal rift and arrived in the universe of the pink monsters.

But Meep's adventure had just begun...
Meep must now integrate into the world of the pink monsters.
For this, Meep will have to make a blend to become a pink monster too.
"""

let reverseLevelTextFr = """
Meep est un petit être bleu.
Il vie dans un univers ou tous les êtres sont bleus,
Mais Meep n'est pas un être comme les autres...

Meep est transgenre...
Son rêve est devenir un être rose dans un autre univers.
Elle sait comment aller dans l'autre univers, ou tout est à l'endroit.

Pour aller dans l'autre univers, elle doit prendre une faille temporelle.
"""

let normalLevelTextFr = """
Meep a traversé la faille et vient d'arriver dans l'univers des êtres roses.

Mais l'aventure de Meep ne fait que commencer...
Meep doit maintenant s'intégrer dans ce nouveau monde.
Pour cela, Meep doit devenir elle même un être rose.
"""

public class HistoryScene: SKScene {

    private let currentLevel: String
    private let continueMessage: String
    private let historyText: String
    private let label: SKLabelNode
    private var lang: String
    private var mapping: MenuClass.Mapping
    
    init(level: String, lang: String, mapping: MenuClass.Mapping) {
        self.lang = lang
        if lang == "fr" {
            continueMessage = "Appuyer sur espace pour continuer..."
        } else {
            continueMessage = "Press space to continue..."
        }
        if lang == "fr" {
            historyText = (level == "Reverse") ? reverseLevelTextFr : normalLevelTextFr
        } else {
            historyText = (level == "Reverse") ? reverseLevelTextEn : normalLevelTextEn
        }
        let size = CGSize(width: 1024, height: 768)
        self.currentLevel = level
        self.label = SKLabelNode(text: self.continueMessage)
        self.mapping = mapping
        super.init(size: size)
        self.backgroundColor = .init(red: 64 / 255, green: 68 / 255, blue: 69 / 255, alpha: 1)
        self.scaleMode = .aspectFill
        self.label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 300)
        self.label.alpha = 0
        self.addChild(self.label)
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
            newScene = ReverseWorld(fileNamed: "levelReverse", lang: self.lang, mapping: self.mapping)!
        } else {
            newScene = NormalWorld(fileNamed: "levelNormal", lang: self.lang, mapping: self.mapping)!
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
