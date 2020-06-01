//
//  Tools.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import Foundation

enum macOSKeyMap: UInt16 {
    case touchZ = 6
    case touchX = 7
    case leftArrow = 123
    case rightArrow = 124
    case upArrow = 126
    case downArrow = 125
    case space = 49
}

enum categoryMask: UInt32 {
    case player = 0x00000001
    case floor = 0x00000002
    case wall = 0x00000004
    case flyingPlatform = 0x00000008
    case rotatePlatform = 0x00000010
    case spade = 0x00000020
    case goal = 0x00000040
}
