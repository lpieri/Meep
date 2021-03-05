//
//  LanguageView.swift
//  Meep
//
//  Created by Louise on 05/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SwiftUI

struct LanguageView: View {
    
    @EnvironmentObject var menuData: MenuClass
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
                    
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        if menuData.lang == "fr" {
                            Text(MenuClass.Fr.menuTitleLang.rawValue).font(.largeTitle)
                        } else {
                            Text(MenuClass.En.menuTitleLang.rawValue).font(.largeTitle)
                        }
                        VStack (alignment: .center, spacing: 10) {
                            Button(action: {menuData.lang = "fr"}, label: {Text("Français")}).buttonStyle(PlainButtonStyle()).font(.title)
                            Button(action: {menuData.lang = "en"}, label: {Text("English")}).buttonStyle(PlainButtonStyle()).font(.title)
                        }
                        Spacer()
                    }.padding()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView()
    }
}
