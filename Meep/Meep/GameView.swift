//
//  GameView.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var body: some View {
        ZStack {
            SpriteKitInterface(scene: HistoryScene(level: "Reverse"))
            Button(action: { NSApplication.shared.terminate(self) }, label: { Image(systemName: "xmark") })
                .buttonStyle(PlainButtonStyle())
                .imageScale(.large)
                .foregroundColor(.red)
                .position(x: 30, y: 30)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
