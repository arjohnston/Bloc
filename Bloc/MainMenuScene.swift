//
//  MainMenuScene.swift
//  Bloc
//
//  Created by Andrew Johnston on 3/17/18.
//  Copyright © 2018 Andrew Johnston. All rights reserved.
//

import Foundation
import SpriteKit

var lastUpdateTime: TimeInterval = 0
var deltaFrameTime: TimeInterval = 0
var amountToMovePerSecondSm: CGFloat = 150.0
var amountToMovePerSecondMd: CGFloat = 125.0
var amountToMovePerSecondLg: CGFloat = 100.0
var backgroundBubblesPositionSm1 = CGPoint(x: 0, y: 0)
var backgroundBubblesPositionSm2 = CGPoint(x: 0, y: 0)
var backgroundBubblesPositionMd1 = CGPoint(x: 0, y: 0)
var backgroundBubblesPositionMd2 = CGPoint(x: 0, y: 0)
var backgroundBubblesPositionLg1 = CGPoint(x: 0, y: 0)
var backgroundBubblesPositionLg2 = CGPoint(x: 0, y: 0)

enum scenes: String {
    case mainMenu
    case game
    case storeMenu
    case settingsMenu
    case creditsMenu
    case none
}
var currentScene = scenes.mainMenu
var previousScene = scenes.none

class MainMenuScene: SKScene {
    let backgroundBubblesSm1 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesSm2 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesMd1 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesMd2 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesLg1 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let backgroundBubblesLg2 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let background = SKSpriteNode(imageNamed: "background")
    let backgroundFlipped = SKSpriteNode(imageNamed: "background-flipped")
    
    override func didMove(to view: SKView) {
        currentScene = scenes.mainMenu

        background.position = CGPoint(x: self.size.width / 2, y: previousScene == scenes.game ? self.size.height / 2 : 0)
        background.zPosition = 0
        background.name = "background"
        background.size = self.size
        background.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.addChild(background)
        
        backgroundFlipped.position = CGPoint(x: self.size.width / 2, y: previousScene == scenes.game ? -self.size.height / 2 + 1 : -self.size.height + 1)
        backgroundFlipped.zPosition = 0
        backgroundFlipped.name = "background"
        backgroundFlipped.size = self.size
        backgroundFlipped.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.addChild(backgroundFlipped)
        
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
        
        
        let gameName = SKLabelNode()
        gameName.text = "BLOC"
        gameName.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        gameName.zPosition = 2
        gameName.alpha = 0
        GameViewController.addAttributesToNode(node: gameName, kernValue: 60.0, fontSize: 275.0)
        self.addChild(gameName)
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.58)
        playButton.zPosition = 2
        playButton.name = "playButton"
        playButton.alpha = 0
        self.addChild(playButton)
        
        let storeButton = SKSpriteNode(imageNamed: "diamond")
        storeButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.43)
        storeButton.zPosition = 2
        storeButton.name = "storeButton"
        storeButton.alpha = 0
        self.addChild(storeButton)
        
        let settingsButton = SKSpriteNode(imageNamed: "settings")
        settingsButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.28)
        settingsButton.zPosition = 2
        settingsButton.name = "settingsButton"
        settingsButton.alpha = 0
        self.addChild(settingsButton)
        
        let waitForDuration = SKAction.wait(forDuration: 0.1)
        let fadeInAction = SKAction.fadeIn(withDuration: 0.4)
        let moveDownAction = SKAction.moveBy(x: 0, y: -30, duration: 0.3)
        let fadeSequence = SKAction.sequence([waitForDuration, fadeInAction])
        let moveSequence = SKAction.sequence([waitForDuration, moveDownAction])
        let fadeMoveGroup = SKAction.group([fadeSequence, moveSequence])
        gameName.run(fadeInAction)
        playButton.run(fadeMoveGroup)
        storeButton.run(fadeMoveGroup)
        settingsButton.run(fadeMoveGroup)
        
        if previousScene == scenes.game {
            let moveDownBg = SKAction.move(by: CGVector(dx: 0, dy: -self.size.height / 2), duration: 0.2)
            background.run(moveDownBg)
            backgroundFlipped.run(moveDownBg)
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)

            let fadeOutAction = SKAction.fadeOut(withDuration: 0.1)
            let moveUpAction = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 0.2)
            let fadeChildren = SKAction.run {
                for node in self.children {
                    if node.name != "background" && node.name != "BackgroundBubbles" {
                        node.run(fadeOutAction)
                    }
                }
            }
            let fadeMoveChildren = SKAction.run {
                for node in self.children {
                    if node.name != "background" && node.name != "BackgroundBubbles" {
                        node.run(SKAction.group([fadeOutAction, moveUpAction]))
                    }
                }
            }
            let moveUpBg = SKAction.move(by: CGVector(dx: 0, dy: self.size.height / 2), duration: 0.2)
            
            if nodeITapped.name != nil {
                previousScene = scenes.mainMenu
                
                switch nodeITapped.name! {
                case "playButton":
                    let sceneToMoveTo = GameScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeMoveChildren)
                    background.run(moveUpBg)
                    backgroundFlipped.run(moveUpBg)
                    self.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.3),
                        SKAction.run{self.view!.presentScene(sceneToMoveTo)}
                        ]))
                    
                case "storeButton":
                    let sceneToMoveTo = StoreMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
                    self.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.2),
                        SKAction.run{self.view!.presentScene(sceneToMoveTo)}
                        ]))
                    
                case "settingsButton":
                    let sceneToMoveTo = SettingsMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
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
