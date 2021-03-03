//
//  MusicOptView.swift
//  Meep
//
//  Created by Louise on 03/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SwiftUI

struct MusicOptView: View {
    
    @State var menuView: Bool = false
    @State var value: Double = 0
    
    var body: some View {
        ZStack {
            if menuView {
                MenuView()
            } else {
                ZStack {
                    Button(action: {
                        menuView.self.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                    }).buttonStyle(PlainButtonStyle()).font(.largeTitle)
                    .foregroundColor(.red)
                    .position(x: 30, y: 30)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Spacer()
                        Text("Music Menu :").font(.largeTitle)
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Volume :").font(.title)
                            Slider(value: $value, in: 0...50, step: 1)
                        }.frame(width: 400, height: .none, alignment: .leading)
                        
                        Text("Music Credits :").font(.largeTitle)
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
