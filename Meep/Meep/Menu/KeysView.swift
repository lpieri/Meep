//
//  KeysView.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import SwiftUI

struct KeysView: View {
    
    @State var menuView: Bool = false
    
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
                    
                    VStack {
                        Image("keys_logo")
                        Spacer()
                        Image("keyboard_touch")
                        Spacer()
                    }.padding()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct KeysView_Previews: PreviewProvider {
    static var previews: some View {
        KeysView()
    }
}
