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
    @State var en: Bool
    
    init() {
        if let lang = UserDefaults.standard.string(forKey: "Lang") {
            if lang == "fr" {
                self._en = State(initialValue: false)
            } else {
                self._en = State(initialValue: true)
            }
        } else {
            self._en = State(initialValue: true)
        }
    }
    
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
                                    UserDefaults.standard.setValue("fr", forKey: "Lang")
                                    self.en.toggle()
                                }, label: {
                                    HStack(alignment: .center, spacing: 15) {
                                        Text("Français")
                                        if !en {
                                            Image(systemName: "checkmark")
                                        } else {
                                            Image(systemName: "multiply")
                                        }
                                    }.font(.title)
                                    .frame(width: 150, height: .none, alignment: .center)
                                    .padding(.all, 8)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .cornerRadius(40)
                                })
                                .buttonStyle(PlainButtonStyle())

                            }
                            
                            HStack(alignment: .center) {
                                Button(action: {
                                    menuData.lang = "en"
                                    UserDefaults.standard.setValue("en", forKey: "Lang")
                                    self.en.toggle()
                                }, label: {
                                    HStack(alignment: .center, spacing: 15) {
                                        Text("English")
                                        if en {
                                            Image(systemName: "checkmark")
                                        } else {
                                            Image(systemName: "multiply")
                                        }
                                    }.font(.title)
                                    .frame(width: 150, height: .none, alignment: .center)
                                    .padding(.all, 8)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .cornerRadius(40)
                                })
                                .buttonStyle(PlainButtonStyle())
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
