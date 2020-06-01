//
//  KeysView.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import SwiftUI

struct KeysView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("keys_logo")
                Spacer()
                Image("keyboard_touch")
                Spacer()
            }.padding()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct KeysView_Previews: PreviewProvider {
    static var previews: some View {
        KeysView()
    }
}
