//
//  MenuClass.swift
//  Meep
//
//  Created by Louise on 03/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import Combine
import SwiftUI

class MenuClass: ObservableObject {
    
    /*
     Enums
     */
    enum macOSDefaultKey: UInt16 {
        case touchZ = 6
        case touchX = 7
        case leftArrow = 123
        case rightArrow = 124
        case upArrow = 126
        case downArrow = 125
        case space = 49
    }
    
    enum touchSlug: String {
        case jump = "jump"
        case crouch = "crouch"
        case runRight = "run-right"
        case runLeft = "run-left"
        case diagJumpLeft = "diag-jump-left"
        case diagJumpRight = "diag-jump-right"
    }
    
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
        case upArrow = "Flèche du haut"
        case downArrow = "Flèche du bas"
        case rightArrow = "Flèche de droite"
        case leftArrow = "Flèche de gauche"
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
        case upArrow = "Up Arrow"
        case downArrow = "Down Arrow"
        case rightArrow = "Right Arrow"
        case leftArrow = "Left Arrow"
    }
    
    /*
     Structures
     */
    class Mapping: Codable {
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
    }
    
    class Touch: Identifiable, Codable {
        var id: Int
        var name: String
        var slug: String
        var touch: String
        
        init () {
            self.id = 0
            self.name = "default"
            self.slug = "default"
            self.touch = "default"
        }
            
        init (id: Int, name: String, slug: String, touch: String) {
            self.id = id
            self.name = name
            self.slug = slug
            self.touch = touch
        }
    }
    
    /*
     Variables
     */
    let didChange = PassthroughSubject<Void, Never>()
    var touchsFr: [Touch] = [
        Touch(id: 0, name: "Saut :", slug: touchSlug.jump.rawValue, touch: Fr.upArrow.rawValue),
        Touch(id: 1, name: "S'accroupir :", slug: touchSlug.crouch.rawValue, touch: Fr.downArrow.rawValue),
        Touch(id: 2, name: "Courir à droite :", slug: touchSlug.runRight.rawValue, touch: Fr.rightArrow.rawValue),
        Touch(id: 3, name: "Courir à gauche :", slug: touchSlug.runLeft.rawValue, touch: Fr.leftArrow.rawValue),
        Touch(id: 4, name: "Saut diagonale à gauche :", slug: "diag-jump-left", touch: "Touche W"),
        Touch(id: 5, name: "Saut diagonale à droite :", slug: "diag-jump-right", touch: "Touche X")
    ] { didSet { didChange.send() } }
    var touchsEn: [Touch] = [
        Touch(id: 0, name: "Jump :", slug: touchSlug.jump.rawValue, touch: En.upArrow.rawValue),
        Touch(id: 1, name: "Crouch :", slug: touchSlug.crouch.rawValue, touch: En.downArrow.rawValue),
        Touch(id: 2, name: "Run Right :", slug: touchSlug.runRight.rawValue, touch: En.rightArrow.rawValue),
        Touch(id: 3, name: "Run Left :", slug: touchSlug.runLeft.rawValue, touch: En.leftArrow.rawValue),
        Touch(id: 4, name: "Diagonal jump left :", slug: "diag-jump-left", touch: "Key Z"),
        Touch(id: 5, name: "Diagonal jump right :", slug: "diag-jump-right", touch: "Key X")
    ] { didSet { didChange.send() } }
    var volume: Double = 0.6 { didSet { didChange.send() } }
    var lang: String = "en" { didSet { didChange.send() } }
    var mapping: Mapping = Mapping() { didSet { didChange.send() } }
    
    /*
     Functions
     */
    func LoadUserDefaults(data: UserDefaults) {
        if let lang = data.string(forKey: "Lang") {
            self.lang = lang
        } else {
            self.lang = "en"
        }
        self.volume = data.double(forKey: "Vol")
        if let keyFr = data.array(forKey: "KeyFr") {
            self.touchsFr = keyFr as! [Touch]
        }
        if let keyEn = data.array(forKey: "KeyEn") {
            self.touchsEn = keyEn as! [Touch]
        }
        do {
            let decoder = JSONDecoder()
            if let keysData = data.object(forKey: "KeyFr") as? Data {
                let keysFR = try decoder.decode([Touch].self, from: keysData)
                self.touchsFr = keysFR
            }
            if let keysData = data.object(forKey: "KeyEn") as? Data {
                let keysEn = try decoder.decode([Touch].self, from: keysData)
                self.touchsEn = keysEn
            }
            if let mappingData = data.object(forKey: "Mapping") as? Data {
                let mapping = try decoder.decode(Mapping.self, from: mappingData)
                self.mapping = mapping
            }
        } catch {
            print("No keys")
        }
    }
    
    func InitUserDefaults(data: UserDefaults) {
        data.setValue(self.volume, forKey: "Vol")
        data.setValue(self.lang, forKey: "Lang")
        do {
            let encoder = JSONEncoder()
            let encodeKeyFr = try encoder.encode(touchsFr)
            let encodeKeyEn = try encoder.encode(touchsEn)
            let encodeMapping = try encoder.encode(mapping)
            data.set(encodeKeyFr, forKey: "KeyFr")
            data.set(encodeKeyEn, forKey: "KeyEn")
            data.set(encodeMapping, forKey: "Mapping")
        } catch {
            print("No Keys save !")
        }
    }
    
    func ChangeKey(slug: String, event: NSEvent) {
        var i: Int = 0
        switch slug {
        case touchSlug.jump.rawValue:
            self.mapping.jump = event.keyCode
        case touchSlug.crouch.rawValue:
            self.mapping.crouch = event.keyCode
            i = 1
        case touchSlug.runLeft.rawValue:
            self.mapping.runLeft = event.keyCode
            i = 3
        case touchSlug.runRight.rawValue:
            self.mapping.runRight = event.keyCode
            i = 2
        case touchSlug.diagJumpLeft.rawValue:
            self.mapping.diagJumpLeft = event.keyCode
            i = 4
        case touchSlug.diagJumpRight.rawValue:
            self.mapping.diagJumpRight = event.keyCode
            i = 5
        default:
            return
        }
        if let char = event.characters {
            switch event.keyCode {
            case macOSDefaultKey.downArrow.rawValue:
                touchsFr[i].touch = Fr.downArrow.rawValue
                touchsEn[i].touch = En.downArrow.rawValue
            case macOSDefaultKey.upArrow.rawValue:
                touchsFr[i].touch = Fr.upArrow.rawValue
                touchsEn[i].touch = En.upArrow.rawValue
            case macOSDefaultKey.leftArrow.rawValue:
                touchsFr[i].touch = Fr.leftArrow.rawValue
                touchsEn[i].touch = En.leftArrow.rawValue
            case macOSDefaultKey.rightArrow.rawValue:
                touchsFr[i].touch = Fr.rightArrow.rawValue
                touchsEn[i].touch = En.rightArrow.rawValue
            default:
                touchsFr[i].touch = "Touche " + char.uppercased()
                touchsEn[i].touch = "Key " + char.uppercased()
            }
        }
        return
    }
    
}
