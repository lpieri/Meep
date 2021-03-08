//
//  KeysView.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import SwiftUI

struct KeysView: View {
    
    @EnvironmentObject var menuData: MenuClass
    @State var menuView: Bool = false
    @State var changeTouch: Bool = false
    @State var textAlert = "Presse touch..."
    
    func changeKey(touch: String) {
        self.changeTouch.toggle()
        if changeTouch {
            menuData.ChangeKey(name: touch, event: NSApplication.shared.nextEvent(matching: .keyDown, until: .distantFuture, inMode: .eventTracking, dequeue: .init())!)
            self.textAlert = "It's done !!"
            print("touch:", touch, changeTouch)
        }
    }
    
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
                            Text(MenuClass.Fr.menuTitleKey.rawValue)
                        } else {
                            Text(MenuClass.En.menuTitleKey.rawValue)
                        }
                        VStack(alignment: .center, spacing: 5) {
                            if menuData.lang == "fr" {
                                ForEach(menuData.touchsFr, content: { touch in
                                    HStack(alignment: .center) {
                                        Text(touch.name)
                                        Spacer()
                                        Button(touch.touch, action: {
                                            changeKey(touch: touch.slug)
                                        }).font(.title)
                                    }
                                })
                            } else {
                                ForEach(menuData.touchsEn, content: { touch in
                                    HStack(alignment: .center) {
                                        Text(touch.name)
                                        Spacer()
                                        Button(touch.touch, action: {
                                            changeKey(touch: touch.slug)
                                        }).font(.title)
                                    }
                                })
                            }
                        }.frame(width: 400, height: .none, alignment: .center)
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        
                    }.padding()
                    .font(.largeTitle)
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
