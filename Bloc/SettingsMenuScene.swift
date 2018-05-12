//
//  SettingsMenuScene.swift
//  Bloc
//
//  Created by Andrew Johnston on 3/20/18.
//  Copyright © 2018 Andrew Johnston. All rights reserved.
//

import Foundation
import SpriteKit
import AudioToolbox

class SettingsMenuScene: SKScene {
    let soundButton = UserDefaults().bool(forKey: "soundEnabledSaved") ? SKSpriteNode(imageNamed: "sound") : SKSpriteNode(imageNamed: "sound-disabled")
    let vibrateButton = UserDefaults().bool(forKey: "vibrateEnabledSaved") ? SKSpriteNode(imageNamed: "vibrate") : SKSpriteNode(imageNamed: "vibrate-disabled")

    let backgroundBubblesSm1 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesSm2 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesMd1 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesMd2 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesLg1 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let backgroundBubblesLg2 = SKSpriteNode(imageNamed: "background-bubbles-large")

    override func didMove(to view: SKView) {
        currentScene = scenes.settingsMenu
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        background.name = "background"
        self.addChild(background)
        
        if backgroundBubblesPositionSm1.x == 0 &&
            backgroundBubblesPositionSm1.y == 0 &&
            backgroundBubblesPositionSm2.x == 0 &&
            backgroundBubblesPositionSm2.y == 0 {
            backgroundBubblesPositionSm1.x = 0
            backgroundBubblesPositionSm1.y = self.size.height / 2
            backgroundBubblesPositionSm2.x = self.size.width
            backgroundBubblesPositionSm2.y = self.size.height / 2
        }
        
        
        backgroundBubblesSm1.size = self.size
        backgroundBubblesSm1.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBubblesSm1.position = CGPoint(x: backgroundBubblesPositionSm1.x,
                                                y: backgroundBubblesPositionSm1.y)
        backgroundBubblesSm1.name = "backgroundBubbles"
        backgroundBubblesSm1.zPosition = 0
        self.addChild(backgroundBubblesSm1)
        
        
        backgroundBubblesSm2.size = self.size
        backgroundBubblesSm2.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBubblesSm2.position = CGPoint(x: backgroundBubblesPositionSm2.x,
                                                y: backgroundBubblesPositionSm2.y)
        backgroundBubblesSm2.name = "backgroundBubbles"
        backgroundBubblesSm2.zPosition = 0
        self.addChild(backgroundBubblesSm2)
        
        if backgroundBubblesPositionMd1.x == 0 &&
            backgroundBubblesPositionMd1.y == 0 &&
            backgroundBubblesPositionMd2.x == 0 &&
            backgroundBubblesPositionMd2.y == 0 {
            backgroundBubblesPositionMd1.x = 0
            backgroundBubblesPositionMd1.y = self.size.height / 2
            backgroundBubblesPositionMd2.x = self.size.width
            backgroundBubblesPositionMd2.y = self.size.height / 2
        }
        
        
        backgroundBubblesMd1.size = self.size
        backgroundBubblesMd1.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBubblesMd1.position = CGPoint(x: backgroundBubblesPositionMd1.x,
                                                y: backgroundBubblesPositionMd1.y)
        backgroundBubblesMd1.name = "backgroundBubbles"
        backgroundBubblesMd1.zPosition = 0
        self.addChild(backgroundBubblesMd1)
        
        
        backgroundBubblesMd2.size = self.size
        backgroundBubblesMd2.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBubblesMd2.position = CGPoint(x: backgroundBubblesPositionMd2.x,
                                                y: backgroundBubblesPositionMd2.y)
        backgroundBubblesMd2.name = "backgroundBubbles"
        backgroundBubblesMd2.zPosition = 0
        self.addChild(backgroundBubblesMd2)
        
        if backgroundBubblesPositionLg1.x == 0 &&
            backgroundBubblesPositionLg1.y == 0 &&
            backgroundBubblesPositionLg2.x == 0 &&
            backgroundBubblesPositionLg2.y == 0 {
            backgroundBubblesPositionLg1.x = 0
            backgroundBubblesPositionLg1.y = self.size.height / 2
            backgroundBubblesPositionLg2.x = self.size.width
            backgroundBubblesPositionLg2.y = self.size.height / 2
        }
        
        
        backgroundBubblesLg1.size = self.size
        backgroundBubblesLg1.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBubblesLg1.position = CGPoint(x: backgroundBubblesPositionLg1.x,
                                                y: backgroundBubblesPositionLg1.y)
        backgroundBubblesLg1.name = "backgroundBubbles"
        backgroundBubblesLg1.zPosition = 0
        self.addChild(backgroundBubblesLg1)
        
        
        backgroundBubblesLg2.size = self.size
        backgroundBubblesLg2.anchorPoint = CGPoint(x: 0, y: 0.5)
        backgroundBubblesLg2.position = CGPoint(x: backgroundBubblesPositionLg2.x,
                                                y: backgroundBubblesPositionLg2.y)
        backgroundBubblesLg2.name = "backgroundBubbles"
        backgroundBubblesLg2.zPosition = 0
        self.addChild(backgroundBubblesLg2)
        
        let backButton = SKSpriteNode(imageNamed: "back")
        backButton.position = CGPoint(x: 100 + backButton.size.width, y: self.size.height - 150)
        backButton.setScale(0.7)
        backButton.zPosition = 2
        backButton.name = "backButton"
        backButton.alpha = 0
        self.addChild(backButton)
        
        soundButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.70)
        soundButton.zPosition = 2
        soundButton.name = "soundButton"
        soundButton.alpha = 0
        self.addChild(soundButton)
        
        vibrateButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.52)
        vibrateButton.zPosition = 2
        vibrateButton.name = "vibrateButton"
        vibrateButton.alpha = 0
        self.addChild(vibrateButton)
        
        let creditsButton = SKSpriteNode(imageNamed: "credits")
        creditsButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
        creditsButton.zPosition = 2
        creditsButton.name = "creditsButton"
        creditsButton.alpha = 0
        self.addChild(creditsButton)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
        let moveDownAction = SKAction.moveBy(x: 0, y: -30, duration: 0.2)
        let fadeMoveGroup = SKAction.group([fadeInAction, moveDownAction])
        backButton.run(fadeInAction)
        soundButton.run(fadeMoveGroup)
        vibrateButton.run(fadeMoveGroup)
        creditsButton.run(fadeMoveGroup)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        } else {
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
        }
        
        let amountToMoveBackgroundSm = amountToMovePerSecondSm * CGFloat(deltaFrameTime)
        backgroundBubblesPositionSm1.x -= amountToMoveBackgroundSm
        backgroundBubblesPositionSm2.x -= amountToMoveBackgroundSm
        
        if backgroundBubblesPositionSm1.x < -self.size.width {
            backgroundBubblesPositionSm1.x += self.size.width * 2
        }
        
        if backgroundBubblesPositionSm2.x < -self.size.width {
            backgroundBubblesPositionSm2.x += self.size.width * 2
        }
        
        backgroundBubblesSm1.position.x = backgroundBubblesPositionSm1.x
        backgroundBubblesSm2.position.x = backgroundBubblesPositionSm2.x
        
        let amountToMoveBackgroundMd = amountToMovePerSecondMd * CGFloat(deltaFrameTime)
        backgroundBubblesPositionMd1.x -= amountToMoveBackgroundMd
        backgroundBubblesPositionMd2.x -= amountToMoveBackgroundMd
        
        if backgroundBubblesPositionMd1.x < -self.size.width {
            backgroundBubblesPositionMd1.x += self.size.width * 2
        }
        
        if backgroundBubblesPositionMd2.x < -self.size.width {
            backgroundBubblesPositionMd2.x += self.size.width * 2
        }
        
        backgroundBubblesMd1.position.x = backgroundBubblesPositionMd1.x
        backgroundBubblesMd2.position.x = backgroundBubblesPositionMd2.x
        
        let amountToMoveBackgroundLg = amountToMovePerSecondLg * CGFloat(deltaFrameTime)
        backgroundBubblesPositionLg1.x -= amountToMoveBackgroundLg
        backgroundBubblesPositionLg2.x -= amountToMoveBackgroundLg
        
        if backgroundBubblesPositionLg1.x < -self.size.width {
            backgroundBubblesPositionLg1.x += self.size.width * 2
        }
        
        if backgroundBubblesPositionLg2.x < -self.size.width {
            backgroundBubblesPositionLg2.x += self.size.width * 2
        }
        
        backgroundBubblesLg1.position.x = backgroundBubblesPositionLg1.x
        backgroundBubblesLg2.position.x = backgroundBubblesPositionLg2.x
    }
    
    func fadeOutChildren() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
        let fadeChildren = SKAction.run {
            for node in self.children {
                if node.name != "background" {
                    node.run(fadeOutAction)
                }
            }
        }
        self.run(SKAction.sequence([fadeChildren, SKAction.wait(forDuration: 0.2)]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            let defaults = UserDefaults()
            
            if nodeITapped.name == "soundButton" {
                if UserDefaults().bool(forKey: "soundEnabledSaved") == true {
                    soundButton.texture = SKTexture(imageNamed: "sound-disabled")
                    defaults.set(false, forKey: "soundEnabledSaved")
                } else if UserDefaults().bool(forKey: "soundEnabledSaved") == false {
                    soundButton.texture = SKTexture(imageNamed: "sound")
                    defaults.set(true, forKey: "soundEnabledSaved")
                }
                
                if UserDefaults().bool(forKey: "vibrateEnabledSaved") {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            }
  
            if nodeITapped.name == "vibrateButton" {
                if UserDefaults().bool(forKey: "vibrateEnabledSaved") == true {
                    vibrateButton.texture = SKTexture(imageNamed: "vibrate-disabled")
                    defaults.set(false, forKey: "vibrateEnabledSaved")
                } else if UserDefaults().bool(forKey: "vibrateEnabledSaved") == false {
                    vibrateButton.texture = SKTexture(imageNamed: "vibrate")
                    defaults.set(true, forKey: "vibrateEnabledSaved")
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            }
            
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.2)
            let fadeChildren = SKAction.run {
                for node in self.children {
                    if node.name != "background" && node.name != "BackgroundBubbles" {
                        node.run(fadeOutAction)
                    }
                }
            }
            
            if nodeITapped.name != nil {
                switch nodeITapped.name! {
                case "backButton":
                    let sceneToMoveTo = MainMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
                    previousScene = scenes.settingsMenu
                    self.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.2),
                        SKAction.run{self.view!.presentScene(sceneToMoveTo)}
                        ]))
    
                case "creditsButton":
                    let sceneToMoveTo = CreditsMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
                    previousScene = scenes.settingsMenu
                    self.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.2),
                        SKAction.run{self.view!.presentScene(sceneToMoveTo)}
                        ]))
                    
                default:
                    break
                }
            }
        }
    }
}
