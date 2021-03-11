//
//  AppDelegate.swift
//  Meep
//
//  Created by Louise on 28/08/2020.
//  Copyright © 2020 Louise Pieri. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let menuData = MenuClass()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if hasLaunchedBefore {
            menuData.LoadUserDefaults(data: UserDefaults.standard)
        } else {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            menuData.InitUserDefaults(data: UserDefaults.standard)
        }
        let menuView = MenuView().environmentObject(menuData)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1024, height: 768),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: menuView)
        window.makeKeyAndOrderFront(nil)
        window.title = "Meep"
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
