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
    @State var en: Bool = true
    
    var body: some View {
        ZStack {
            if menuView {
                MenuView()
            } else {
                ZStack {
                    ButtonReturn(menuView: $menuView)
                    
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        if menuData.lang == "fr" {
                            Text(MenuClass.Fr.menuTitleLang.rawValue)
                        } else {
                            Text(MenuClass.En.menuTitleLang.rawValue)
                        }
                        
                        VStack(alignment: .center, spacing: 5) {
                            HStack(alignment: .center) {
                                Button(action: {
                                    menuData.lang = "fr"
                                    self.en.toggle()
                                }, label: {Text("Français")}).buttonStyle(PlainButtonStyle())
                                if !en {
                                    Image(systemName: "checkmark")
                                }
                            }
                            
                            HStack(alignment: .center) {
                                Button(action: {
                                    menuData.lang = "en"
                                    self.en.toggle()
                                }, label: {Text("English")}).buttonStyle(PlainButtonStyle())
                                if en {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }.frame(width: 400, height: .none, alignment: .center)
                        
                        Spacer()
                    }.padding()
                    .font(.largeTitle)
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
