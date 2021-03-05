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
                        Text("Keyboard Menu :").font(.largeTitle)
                        VStack(alignment: .center, spacing: 5) {
                            HStack(alignment: .center) {
                                Text("Jump:").font(.title)
                                Spacer()
                                Button("Up Arrow", action: {
                                    changeKey(touch: "jump")
                                })
                                if changeTouch {
                                    Text(self.textAlert)
                                }
                            }
                            HStack(alignment: .center) {
                                Text("Crouch:").font(.title)
                                Spacer()
                                Button("Down Arrow", action: {
                                    changeKey(touch: "crouch")
                                })
                            }
                            HStack(alignment: .center) {
                                Text("Run Right:").font(.title)
                                Spacer()
                                Button("Right Arrow", action: {
                                    changeKey(touch: "run-right")
                                })
                            }
                            HStack(alignment: .center) {
                                Text("Run Left:").font(.title)
                                Spacer()
                                Button("Left Arrow", action: {
                                    changeKey(touch: "run-left")
                                })
                            }
                            HStack(alignment: .center) {
                                Text("Diagonal jump left:").font(.title)
                                Spacer()
                                Button("Z Touch", action: {
                                    changeKey(touch: "diag-jump-left")
                                })
                            }
                            HStack(alignment: .center) {
                                Text("Diagonal jump right:").font(.title)
                                Spacer()
                                Button("X Touch", action: {
                                    changeKey(touch: "diag-jump-right")
                                })
                            }
                        }.frame(width: 400, height: .none, alignment: .center)
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
