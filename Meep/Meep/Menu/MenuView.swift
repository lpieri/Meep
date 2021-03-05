//
//  ContentView.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var menuData: MenuClass
    @State var keyOption: Bool = false
    @State var musicOpt: Bool = false
    @State var gameView: Bool = false
    @State var langView: Bool = false
    
    var body: some View {
        ZStack {
            if keyOption {
                KeysView()
            } else if musicOpt {
                MusicOptView()
            } else if gameView {
                GameView()
            } else if langView {
                LanguageView()
            } else {
                VStack {
                    Image("meep_logo")
                    VStack (alignment: .center, spacing: 10) {
                        
                        Button(action: { gameView.self.toggle() }, label: {
                            if menuData.lang == "fr" {
                                Text(MenuClass.Fr.startGame.rawValue)
                            } else {
                                Text(MenuClass.En.startGame.rawValue)
                            }
                        })
                        
                        Button(action: { self.langView.toggle() }, label: {
                            if menuData.lang == "fr" {
                                Text(MenuClass.Fr.lang.rawValue)
                            } else {
                                Text(MenuClass.En.lang.rawValue)
                            }
                        })
                        
                        Button(action: { self.keyOption.toggle() }, label: {
                            if menuData.lang == "fr" {
                                Text(MenuClass.Fr.key.rawValue)
                            } else {
                                Text(MenuClass.En.key.rawValue)
                            }
                        })
                        
                        Button(action: { self.musicOpt.toggle() }, label: {
                            if menuData.lang == "fr" {
                                Text(MenuClass.Fr.music.rawValue)
                            } else {
                                Text(MenuClass.En.music.rawValue)
                            }
                        })
                        
                        Button(action: { NSApplication.shared.terminate(self) }, label: {
                            if menuData.lang == "fr" {
                                Text(MenuClass.Fr.exit.rawValue)
                            } else {
                                Text(MenuClass.En.exit.rawValue)
                            }
                        })
                    }.padding(.vertical, 21.0).font(.largeTitle).buttonStyle(PlainButtonStyle())
                    
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
