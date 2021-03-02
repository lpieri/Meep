//
//  InterfaceSpriteKit.swift
//  Meep
//
//  Created by Louise on 15/02/2021.
//  Copyright © 2021 Louise Pieri. All rights reserved.
//

import SwiftUI
import SpriteKit
import AppKit

struct SpriteKitInterface: NSViewRepresentable {
    
    typealias UIViewType = SKView
    var skScene: SKScene!
    
    init(scene: SKScene) {
        skScene = scene
        self.skScene.scaleMode = .aspectFill
    }
    
    class Coordinator: NSObject {
        var scene: SKScene?
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator()
        coordinator.scene = self.skScene
        return coordinator
    }
    
    func makeNSView(context: Context) -> SKView {
        let view = SKView(frame: .zero)
        view.preferredFramesPerSecond = 128
        view.showsFPS = false
        view.showsNodeCount = false
        
        return view
    }
    
    func updateNSView(_ view: SKView, context: Context) {
        view.presentScene(context.coordinator.scene)
    }
}
