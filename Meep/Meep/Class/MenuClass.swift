//
//  MenuClass.swift
//  Meep
//
//  Created by Louise on 03/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import Combine
import SwiftUI

enum macOSDefaultKey: UInt16 {
    case touchZ = 6
    case touchX = 7
    case leftArrow = 123
    case rightArrow = 124
    case upArrow = 126
    case downArrow = 125
    case space = 49
}

enum touchName: String {
    case jump = "jump"
    case crouch = "crouch"
    case runRight = "run-right"
    case runLeft = "run-left"
    case diagJumpLeft = "diag-jump-left"
    case diagJumpRight = "diag-jump-right"
}

class MenuClass: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    enum Fr: String {
        case startGame = "Commencer le jeu"
        case lang = "Language"
        case key = "Clavier"
        case music = "Audio"
        case exit = "Quitter"
        case menuTitleKey = "Menu du Clavier :"
        case menuTitleMusic = "Menu Audio :"
        case menuTitleLang = "Menu Language :"
        case menuTitleCredits = "Crédits Musicaux :"
    }
    
    enum En: String {
        case startGame = "Start Game"
        case lang = "Language"
        case key = "Keyboard"
        case music = "Audio"
        case exit = "Quit"
        case menuTitleKey = "Keyboard Menu :"
        case menuTitleMusic = "Audio Menu :"
        case menuTitleLang = "Language Menu :"
        case menuTitleCredits = "Music Credits :"
    }
    
    struct Mapping {
        var jump: UInt16
        var crouch: UInt16
        var runRight: UInt16
        var runLeft: UInt16
        var diagJumpLeft: UInt16
        var diagJumpRight: UInt16
        
        init() {
            self.jump = macOSDefaultKey.upArrow.rawValue
            self.crouch = macOSDefaultKey.downArrow.rawValue
            self.runRight = macOSDefaultKey.rightArrow.rawValue
            self.runLeft = macOSDefaultKey.leftArrow.rawValue
            self.diagJumpLeft = macOSDefaultKey.touchZ.rawValue
            self.diagJumpRight = macOSDefaultKey.touchX.rawValue
        }
        
        mutating func ChangeKey(slug: String, event: NSEvent) {
            switch slug {
            case touchName.jump.rawValue:
                self.jump = event.keyCode
            case touchName.crouch.rawValue:
                self.crouch = event.keyCode
            case touchName.runLeft.rawValue:
                self.runLeft = event.keyCode
            case touchName.runRight.rawValue:
                self.runRight = event.keyCode
            case touchName.diagJumpLeft.rawValue:
                self.diagJumpLeft = event.keyCode
            case touchName.diagJumpRight.rawValue:
                self.diagJumpRight = event.keyCode
            default:
                return
            }
            return
        }
    }
    
    struct Touch: Identifiable {
        var id: NSNumber
        var name: String
        var slug: String
        var touch: String
        
        init () {
            self.id = NSNumber(0)
            self.name = "default"
            self.slug = "default"
            self.touch = "default"
        }
            
        init (id: NSNumber, name: String, slug: String, touch: String) {
            self.id = id
            self.name = name
            self.slug = slug
            self.touch = touch
        }
    }
    
    var touchsFr: [Touch] = [
        Touch(id: 0, name: "Saut :", slug: "jump", touch: "Flèche du haut"),
        Touch(id: 1, name: "S'accroupir :", slug: "crouch", touch: "Flèche du bas"),
        Touch(id: 2, name: "Courir à droite :", slug: "run-right", touch: "Flèche de droite"),
        Touch(id: 3, name: "Courir à gauche :", slug: "run-left", touch: "Flèche de gauche"),
        Touch(id: 4, name: "Saut diagonale à gauche :", slug: "diag-jump-left", touch: "Touche Z"),
        Touch(id: 6, name: "Saut diagonale à droite :", slug: "diag-jump-right", touch: "Touche X")
    ] { didSet { didChange.send() } }

    var touchsEn: [Touch] = [
        Touch(id: 0, name: "Jump :", slug: "jump", touch: "Up Arrow"),
        Touch(id: 1, name: "Crouch :", slug: "crouch", touch: "Down Arrow"),
        Touch(id: 2, name: "Run Right :", slug: "run-right", touch: "Right Arrow"),
        Touch(id: 3, name: "Run Left :", slug: "run-left", touch: "Left Arrow"),
        Touch(id: 4, name: "Diagonal jump left :", slug: "diag-jump-left", touch: "Touch Z"),
        Touch(id: 6, name: "Diagonal jump right :", slug: "diag-jump-right", touch: "Touch X")
    ] { didSet { didChange.send() } }
    
    var volume: Double = 0.6 { didSet { didChange.send() } }
    var lang: String = "en" { didSet { didChange.send() } }
    var mapping: Mapping = Mapping() { didSet { didChange.send() } }
    
}
