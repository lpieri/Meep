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
    
    @EnvironmentObject var menuData: MenuClass
    @State var menuView: Bool = false
    
    var body: some View {
        if menuView {
            MenuView()
        } else {
            ZStack {
                SpriteKitInterface(scene: HistoryScene(level: "Reverse", lang: menuData.lang), volume: Float(menuData.volume))
                Button(action: { menuView.self.toggle() }, label: { Image(systemName: "xmark") })
                    .buttonStyle(PlainButtonStyle())
                    .imageScale(.large)
                    .foregroundColor(.red)
                    .position(x: 30, y: 30)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
