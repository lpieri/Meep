//: A SpriteKit based Playground

import PlaygroundSupport
import AVKit
import SpriteKit

let Width = 1024
let Height = 768

let url = Bundle.main.url(forResource: "vlad-gluschenko-sea-breeze", withExtension: "mp3")!
let player = try! AVAudioPlayer(contentsOf: url)
player.volume = 0.3
//player.play()

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: Width, height: Height))
let scene = StartGame()
scene.scaleMode = .aspectFill
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
 
