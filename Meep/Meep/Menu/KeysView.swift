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
        self.textAlert = "Presse touch..."
        self.changeTouch.toggle()
        if changeTouch {
            menuData.ChangeKey(slug: touch, event: NSApplication.shared.nextEvent(matching: .keyDown, until: .distantFuture, inMode: .eventTracking, dequeue: .init())!)
            self.changeTouch.toggle()
            print("touch:", touch, changeTouch)
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
                            Text(MenuClass.Fr.menuTitleKey.rawValue)
                        } else {
                            Text(MenuClass.En.menuTitleKey.rawValue)
                        }
                        VStack(alignment: .center, spacing: 5) {
                            ForEach(menuData.lang == "fr" ? menuData.touchsFr : menuData.touchsEn, content: { touch in
                                HStack(alignment: .center) {
                                    Text(touch.name)
                                    Spacer()
                                    Button(action: {
                                        changeKey(touch: touch.slug)
                                    }, label: {
                                        Text(touch.touch)
                                        .frame(width: 200, height: .none, alignment: .center)
                                        .padding(.all, 8)
                                        .foregroundColor(.white)
                                        .background(Color.gray)
                                        .cornerRadius(40)
                                    }).font(.title)
                                }
                            })
                            if changeTouch {
                                Text(self.textAlert)
                            }
                        }.frame(width: 600, height: .none, alignment: .center)
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
