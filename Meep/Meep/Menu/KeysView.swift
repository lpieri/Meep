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
                            HStack(alignment: .center) {
                                if menuData.lang == "fr" {
                                    Text(MenuClass.Fr.touchJump.rawValue)
                                } else {
                                    Text(MenuClass.En.touchJump.rawValue)
                                }
                                Spacer()
                                Button("Up Arrow", action: {
                                    changeKey(touch: "jump")
                                })
                                if changeTouch {
                                    Text(self.textAlert)
                                }
                            }
                            HStack(alignment: .center) {
                                if menuData.lang == "fr" {
                                    Text(MenuClass.Fr.touchCrouch.rawValue)
                                } else {
                                    Text(MenuClass.En.touchCrouch.rawValue)
                                }
                                Spacer()
                                Button("Down Arrow", action: {
                                    changeKey(touch: "crouch")
                                })
                            }
                            HStack(alignment: .center) {
                                if menuData.lang == "fr" {
                                    Text(MenuClass.Fr.touchRunRight.rawValue)
                                } else {
                                    Text(MenuClass.En.touchRunRight.rawValue)
                                }
                                Spacer()
                                Button("Right Arrow", action: {
                                    changeKey(touch: "run-right")
                                })
                            }
                            HStack(alignment: .center) {
                                if menuData.lang == "fr" {
                                    Text(MenuClass.Fr.touchRunLeft.rawValue)
                                } else {
                                    Text(MenuClass.En.touchRunLeft.rawValue)
                                }
                                Spacer()
                                Button("Left Arrow", action: {
                                    changeKey(touch: "run-left")
                                })
                            }
                            HStack(alignment: .center) {
                                if menuData.lang == "fr" {
                                    Text(MenuClass.Fr.touchDiagJumpLeft.rawValue)
                                } else {
                                    Text(MenuClass.En.touchDiagJumpLeft.rawValue)
                                }
                                Spacer()
                                Button("Z Touch", action: {
                                    changeKey(touch: "diag-jump-left")
                                })
                            }
                            HStack(alignment: .center) {
                                if menuData.lang == "fr" {
                                    Text(MenuClass.Fr.touchDiagJumpRight.rawValue)
                                } else {
                                    Text(MenuClass.En.touchDiagJumpRight.rawValue)
                                }
                                Spacer()
                                Button("X Touch", action: {
                                    changeKey(touch: "diag-jump-right")
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
