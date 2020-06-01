//
//  ContentView.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @State var optionView: Bool = false
    @State var gameView: Bool = false
    
    var body: some View {
        ZStack {
            if optionView {
                OptionView()
            } else if gameView {
                GameView()
            } else {
                VStack {
                    Image("meep_logo")
                    VStack (alignment: .center, spacing: 10) {
                        Button(action: {gameView.self.toggle()}, label: {Text("Start Game")}).buttonStyle(PlainButtonStyle())
                        Button(action: {self.optionView.toggle()}, label: {Text("Option")}).buttonStyle(PlainButtonStyle())
                        Button(action: {NSApplication.shared.terminate(self)}, label: {Text("Quit")}).buttonStyle(PlainButtonStyle())
                    }.padding(.vertical, 21.0)
                        .font(.largeTitle)
                    
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
