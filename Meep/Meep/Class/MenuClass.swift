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
    
    var volume: Double = 0.6 { didSet { didChange.send() } }
    var lang: String = "en" { didSet { didChange.send() } }
    
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
        case touchJump = "Saut :"
        case touchCrouch = "S'accroupir :"
        case touchRunRight = "Courir à droite :"
        case touchRunLeft = "Courir à gauche :"
        case touchDiagJumpLeft = "Saut diagonale à gauche :"
        case touchDiagJumpRight = "Saut diagonale à droite :"
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
        case touchJump = "Jump :"
        case touchCrouch = "Crouch :"
        case touchRunRight = "Run Right :"
        case touchRunLeft = "Run Left :"
        case touchDiagJumpLeft = "Diagonal jump left :"
        case touchDiagJumpRight = "Diagonal jump right :"
    }
    
    var jump: UInt16 = macOSDefaultKey.upArrow.rawValue { didSet { didChange.send() } }
    var crouch: UInt16 = macOSDefaultKey.downArrow.rawValue { didSet { didChange.send() } }
    var runRight: UInt16 = macOSDefaultKey.rightArrow.rawValue { didSet { didChange.send() } }
    var runLeft: UInt16 = macOSDefaultKey.leftArrow.rawValue { didSet { didChange.send() } }
    var diagJumpLeft: UInt16 = macOSDefaultKey.touchZ.rawValue { didSet { didChange.send() } }
    var diagJumpRight: UInt16 = macOSDefaultKey.touchX.rawValue { didSet { didChange.send() } }
    
    func ChangeKey(name: String, event: NSEvent) {
        switch name {
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
