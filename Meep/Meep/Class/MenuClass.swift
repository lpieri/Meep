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
    
    let didChange = PassthroughSubject<Void, Never>()
    
    var volume: Double = 0.6 { didSet { didChange.send() } }
    
}
