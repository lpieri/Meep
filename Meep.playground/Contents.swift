//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

let Width = 1024
let Height = 768

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: Width, height: Height))
let scene = Credits()
scene.scaleMode = .aspectFill
sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
