//
//  MusicOptView.swift
//  Meep
//
//  Created by Louise on 03/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SwiftUI

struct MusicOptView: View {
    
    @EnvironmentObject var menuData: MenuClass
    @State var menuView: Bool = false
    @State var value: Double = 0
    
    var body: some View {
        ZStack {
            if menuView {
                MenuView()
            } else {
                ZStack {
                    ButtonReturn(menuView: $menuView)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Spacer()
                        if menuData.lang == "fr" {
                            Text(MenuClass.Fr.menuTitleMusic.rawValue).font(.largeTitle)
                        } else {
                            Text(MenuClass.En.menuTitleMusic.rawValue).font(.largeTitle)
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Volume :").font(.title)
                            Slider(value: $menuData.volume, in: 0...5, step: 0.3)
                        }.frame(width: 400, height: .none, alignment: .leading)
                        
                        if menuData.lang == "fr" {
                            Text(MenuClass.Fr.menuTitleCredits.rawValue).font(.largeTitle)
                        } else {
                            Text(MenuClass.En.menuTitleCredits.rawValue).font(.largeTitle)
                        }
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                            Text("Sea Breeze by Vlad Gluschenko | https://soundcloud.com/vgl9").font(.headline)
                            Text("Music promoted by https://www.free-stock-music.com").font(.headline)
                            Text("Creative Commons Attribution 3.0 Unported License").font(.headline)
                            Text("https://creativecommons.org/licenses/by/3.0/deed.en_US").font(.headline)
                        }
                        Spacer()
                    }.padding()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MusicOptView_Previews: PreviewProvider {
    static var previews: some View {
        MusicOptView()
    }
}
