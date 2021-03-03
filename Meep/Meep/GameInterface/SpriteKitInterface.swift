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
import AVKit

struct SpriteKitInterface: NSViewRepresentable {
    
    typealias UIViewType = SKView
    var skScene: SKScene!
    var songVol: Float!
    var player: AVAudioPlayer!
    let url = Bundle.main.url(forResource: "vlad-gluschenko-sea-breeze", withExtension: "mp3")!
    
    
    init(scene: SKScene, volume: Float) {
        skScene = scene
        self.songVol = volume
        self.skScene.scaleMode = .aspectFill
        self.player = try! AVAudioPlayer(contentsOf: self.url)
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
        player.volume = self.songVol!
        player.numberOfLoops = -1
        player.play()
        return view
    }
    
    func updateNSView(_ view: SKView, context: Context) {
        view.presentScene(context.coordinator.scene)
    }
}
