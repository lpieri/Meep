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
