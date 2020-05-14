import Foundation

enum macOSKeyMap: UInt16 {
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
