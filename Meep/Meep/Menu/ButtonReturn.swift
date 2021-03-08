//
//  ButtonReturn.swift
//  Meep
//
//  Created by Louise on 08/03/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SwiftUI

struct ButtonReturn: View {
    @Binding var menuView: Bool
    
    var body: some View {
        Button(action: {
            self.menuView.toggle()
        }, label: {
            Image(systemName: "chevron.left")
        }).buttonStyle(PlainButtonStyle()).font(.largeTitle)
        .foregroundColor(.red)
        .position(x: 30, y: 30)
    }
}
