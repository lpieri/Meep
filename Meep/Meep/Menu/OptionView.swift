//
//  OptionView.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import SwiftUI

struct OptionView: View {
    
    @State var menuView: Bool = false
    @State var keyOption: Bool = false
    @State var musicOpt: Bool = false
    
    var body: some View {
        ZStack {
            if menuView {
                MenuView()
            } else if keyOption {
                KeysView()
            } else if musicOpt {
                MusicOptView()
            } else {
                ZStack {
                    Button(action: {
                            menuView.self.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                    }).buttonStyle(PlainButtonStyle()).font(.largeTitle)
                    .foregroundColor(.red)
                    .position(x: 30, y: 30)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("OPTIONS :").font(.largeTitle)
     
                        VStack(alignment: .center, spacing: 10) {
                            Button(action: {
                                    self.keyOption.toggle()
                            }, label: {
                                Text("Keyboard")
                            }).buttonStyle(PlainButtonStyle())
                            
                            Button(action: {
                                    self.musicOpt.toggle()
                            }, label: {
                                Text("Music")
                            }).buttonStyle(PlainButtonStyle())
                        }.padding(.vertical, 21.0).font(.title)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
    }
}
