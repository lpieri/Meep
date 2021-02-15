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
    
    var body: some View {
        ZStack {
            if menuView {
                MenuView()
            } else {
                NavigationView {
                    HStack {
                        List {
                            
                            Button(action: {
                                    self.menuView.toggle()
                                
                            }, label: {
                                Image(systemName: "chevron.left.2")
                                Text("Return")
                            })
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.red)
                            
                            NavigationLink(destination: KeysView(), label: { Text("Keys") })
                            
                        }.listStyle(SidebarListStyle())
                            .font(.largeTitle)
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
