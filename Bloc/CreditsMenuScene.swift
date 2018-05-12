//
//  CreditsMenuScene.swift
//  Bloc
//
//  Created by Andrew Johnston on 3/20/18.
//  Copyright © 2018 Andrew Johnston. All rights reserved.
//

import Foundation
import SpriteKit

class CreditsMenuScene: SKScene {
    let backgroundBubblesSm1 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesSm2 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesMd1 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesMd2 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesLg1 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let backgroundBubblesLg2 = SKSpriteNode(imageNamed: "background-bubbles-large")
    override func didMove(to view: SKView) {
        currentScene = scenes.creditsMenu
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
        
        let titleDev = SKLabelNode()
        titleDev.text = "DEVELOPER"
        titleDev.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        titleDev.position = CGPoint(x: 275, y: self.size.height * 0.78)
        titleDev.zPosition = 2
        titleDev.alpha = 0
        GameViewController.addAttributesToNode(node: titleDev, fontFamily: "Montserrat-Light", kernValue: 7.0, fontSize: 50.0)
        self.addChild(titleDev)
        
        let name1 = SKLabelNode()
        name1.text = "ANDREW JOHNSTON"
        name1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        name1.position = CGPoint(x: 275, y: self.size.height * 0.735)
        name1.zPosition = 2
        name1.alpha = 0
        GameViewController.addAttributesToNode(node: name1, kernValue: 5.0, fontSize: 85.0)
        self.addChild(name1)
        
        let titleThanks = SKLabelNode()
        titleThanks.text = "SPECIAL THANKS"
        titleThanks.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        titleThanks.position = CGPoint(x: 275, y: self.size.height * 0.63)
        titleThanks.zPosition = 2
        titleThanks.alpha = 0
        GameViewController.addAttributesToNode(node: titleThanks, fontFamily: "Montserrat-Light", kernValue: 7.0, fontSize: 50.0)
        self.addChild(titleThanks)
        
        let name2 = SKLabelNode()
        name2.text = "JORDYN DUNCAN"
        name2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        name2.position = CGPoint(x: 275, y: self.size.height * 0.585)
        name2.zPosition = 2
        name2.alpha = 0
        GameViewController.addAttributesToNode(node: name2, kernValue: 5.0, fontSize: 85.0)
        self.addChild(name2)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
        backButton.run(fadeInAction)
        titleDev.run(SKAction.sequence([SKAction.wait(forDuration: 0.15), fadeInAction]))
        name1.run(SKAction.sequence([SKAction.wait(forDuration: 0.15), fadeInAction]))
        titleThanks.run(SKAction.sequence([SKAction.wait(forDuration: 0.2), fadeInAction]))
        name2.run(SKAction.sequence([SKAction.wait(forDuration: 0.2), fadeInAction]))
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
                    let sceneToMoveTo = SettingsMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
                    previousScene = scenes.creditsMenu
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
