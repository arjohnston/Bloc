//
//  GameViewController.swift
//  Bloc
//
//  Created by Andrew Johnston on 3/17/18.
//  Copyright © 2018 Andrew Johnston. All rights reserved.
//

import UIKit
import SpriteKit
//import AVFoundation

class GameViewController: UIViewController {
//    var backingAudio = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let filePath = Bundle.main.path(forResource: "Backing Audio", ofType: "mp3")
//        let audioURL = URL(fileURLWithPath: filePath!)
//
//        do { backingAudio = try AVAudioPlayer(contentsOf: audioURL) }
//        catch { return print("Cannot Find The Audio") }
//
//        backingAudio.numberOfLoops = -1
//        backingAudio.play()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
    
    class func addAttributesToNode(node: SKLabelNode, fontFamily: String = "Montserrat-Regular", kernValue: CGFloat = 0.0, fontSize: CGFloat = 50.0) {
        let attributedString = NSMutableAttributedString(string: node.text!)
        attributedString.addAttribute(NSAttributedStringKey.kern,
                                      value: CGFloat(kernValue),
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor,
                                      value: SKColor.white,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.font,
                                      value: UIFont(name: fontFamily, size: fontSize)! as Any,
                                      range: NSRange(location: 0, length: attributedString.length))
        node.attributedText = attributedString
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
