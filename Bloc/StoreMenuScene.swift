//
//  StoreMenuScene.swift
//  Bloc
//
//  Created by Andrew Johnston on 3/20/18.
//  Copyright © 2018 Andrew Johnston. All rights reserved.
//

import Foundation
import SpriteKit
import AudioToolbox

class StoreMenuScene: SKScene {
    var diamondsCount = UserDefaults().integer(forKey: "diamondsCountSaved")
    var targetItemCount = UserDefaults().integer(forKey: "targetItemCountSaved")
    var bombItemCount = UserDefaults().integer(forKey: "bombItemCountSaved")
    var x2ItemCount = UserDefaults().integer(forKey: "x2ItemCountSaved")
    var rowItemCount = UserDefaults().integer(forKey: "rowItemCountSaved")

    let backgroundBubblesSm1 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesSm2 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesMd1 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesMd2 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesLg1 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let backgroundBubblesLg2 = SKSpriteNode(imageNamed: "background-bubbles-large")
    
    let diamondCount = SKLabelNode(fontNamed: "Montserrat Regular")
    let diamondIcon = SKSpriteNode(imageNamed: "diamond-icon")
    let rowCountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let targetCountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let x2CountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let bombCountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let rowButton = SKSpriteNode(imageNamed: "row")
    let bombButton = SKSpriteNode(imageNamed: "bomb")
    let x2Button = SKSpriteNode(imageNamed: "x2")
    let targetButton = SKSpriteNode(imageNamed: "target")
    let buyButton1 = SKSpriteNode(imageNamed: "buy-25")
    let buyButton2 = SKSpriteNode(imageNamed: "buy-50")
    let buyButton3 = SKSpriteNode(imageNamed: "buy-100")
    
    let PRICE_OF_TARGET = 5
    let PRICE_OF_X2 = 10
    let PRICE_OF_BOMB = 5
    let PRICE_OF_ROW = 10

    override func didMove(to view: SKView) {
        currentScene = scenes.storeMenu
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
        
        diamondCount.text = "\(diamondsCount)"
        diamondCount.fontSize = 80
        diamondCount.fontColor = SKColor.white
        diamondCount.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        diamondCount.position = CGPoint(x: self.size.width - diamondCount.frame.width - 275, y: self.size.height - 175)
        diamondCount.zPosition = 2
        diamondCount.alpha = 0
        self.addChild(diamondCount)
        
        diamondIcon.position = CGPoint(x: self.size.width - diamondCount.frame.width - 350, y: self.size.height - 150)
        diamondIcon.zPosition = 2
        diamondIcon.alpha = 0
        self.addChild(diamondIcon)
        
        buyButton1.position = CGPoint(x: self.size.width / 3 - buyButton1.frame.width / 2, y: self.size.height * 0.75)
        buyButton1.zPosition = 2
        buyButton1.name = "buyButton1"
        buyButton1.alpha = 0
        self.addChild(buyButton1)
        
        let buyButton1PriceLabel = SKLabelNode(fontNamed: "Montserrat Light")
        buyButton1PriceLabel.text = "$1.99"
        buyButton1PriceLabel.fontSize = 55
        buyButton1PriceLabel.fontColor = SKColor.white
        buyButton1PriceLabel.position = CGPoint(x: self.size.width / 3 - buyButton1.frame.width / 2, y: self.size.height * 0.66)
        buyButton1PriceLabel.zPosition = 2
        buyButton1PriceLabel.alpha = 0
        self.addChild(buyButton1PriceLabel)
        
        buyButton2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        buyButton2.zPosition = 2
        buyButton2.name = "buyButton2"
        buyButton2.alpha = 0
        self.addChild(buyButton2)
        
        let buyButton2PriceLabel = SKLabelNode(fontNamed: "Montserrat Light")
        buyButton2PriceLabel.text = "$2.99"
        buyButton2PriceLabel.fontSize = 55
        buyButton2PriceLabel.fontColor = SKColor.white
        buyButton2PriceLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.66)
        buyButton2PriceLabel.zPosition = 2
        buyButton2PriceLabel.alpha = 0
        self.addChild(buyButton2PriceLabel)
        
        buyButton3.position = CGPoint(x: self.size.width * (2 / 3) + buyButton3.frame.width / 2, y: self.size.height * 0.75)
        buyButton3.zPosition = 2
        buyButton3.name = "buyButton3"
        buyButton3.alpha = 0
        self.addChild(buyButton3)
        
        let buyButton3PriceLabel = SKLabelNode(fontNamed: "Montserrat Light")
        buyButton3PriceLabel.text = "$4.99"
        buyButton3PriceLabel.fontSize = 55
        buyButton3PriceLabel.fontColor = SKColor.white
        buyButton3PriceLabel.position = CGPoint(x: self.size.width * (2 / 3) + buyButton3.frame.width / 2, y: self.size.height * 0.66)
        buyButton3PriceLabel.zPosition = 2
        buyButton3PriceLabel.alpha = 0
        self.addChild(buyButton3PriceLabel)
        
        
        targetButton.position = CGPoint(x: self.size.width / 3, y: self.size.height * 0.5)
        targetButton.zPosition = 2
        targetButton.name = "targetButton"
        targetButton.alpha = 0
        self.addChild(targetButton)
        
        let targetCountBg = SKSpriteNode(imageNamed: "counter-bg")
        targetCountBg.position = CGPoint(x: targetButton.position.x + targetButton.frame.width / 2 - 30, y: targetButton.position.y + 90)
        targetCountBg.zPosition = 3
        targetCountBg.alpha = 0
        self.addChild(targetCountBg)
        
        targetCountLabel.text = "\(targetItemCount)"
        targetCountLabel.fontSize = 55
        targetCountLabel.fontColor = SKColor.white
        targetCountLabel.position = CGPoint(x: targetCountBg.position.x, y: targetCountBg.position.y - targetCountLabel.frame.height / 2)
        targetCountLabel.zPosition = 4
        targetCountLabel.alpha = 0
        self.addChild(targetCountLabel)
        
        let diamondCount2 = SKLabelNode(fontNamed: "Montserrat Light")
        let diamondIcon2 = SKSpriteNode(imageNamed: "diamond-icon")
        diamondCount2.text = "x\(PRICE_OF_TARGET)"
        diamondCount2.fontSize = 55
        diamondCount2.fontColor = SKColor.white
        diamondCount2.position = CGPoint(x: self.size.width / 3 + diamondIcon2.frame.width / 2, y: self.size.height * 0.41)
        diamondCount2.zPosition = 2
        diamondCount2.alpha = 0
        self.addChild(diamondCount2)
        
        diamondIcon2.position = CGPoint(x: self.size.width / 3 - diamondCount2.frame.width / 2, y: self.size.height * 0.42)
        diamondIcon2.zPosition = 2
        diamondIcon2.alpha = 0
        diamondIcon2.setScale(0.75)
        self.addChild(diamondIcon2)

        
        
        x2Button.position = CGPoint(x: self.size.width *  (2 / 3), y: self.size.height * 0.5)
        x2Button.zPosition = 2
        x2Button.name = "x2Button"
        x2Button.alpha = 0
        self.addChild(x2Button)
        
        let x2CountBg = SKSpriteNode(imageNamed: "counter-bg")
        x2CountBg.position = CGPoint(x: x2Button.position.x + x2Button.frame.width / 2 - 30, y: x2Button.position.y + 90)
        x2CountBg.zPosition = 3
        x2CountBg.alpha = 0
        self.addChild(x2CountBg)
        
        x2CountLabel.text = "\(x2ItemCount)"
        x2CountLabel.fontSize = 55
        x2CountLabel.fontColor = SKColor.white
        x2CountLabel.position = CGPoint(x: x2CountBg.position.x, y: x2CountBg.position.y - x2CountLabel.frame.height / 2)
        x2CountLabel.zPosition = 4
        x2CountLabel.alpha = 0
        self.addChild(x2CountLabel)
        
        let diamondCount3 = SKLabelNode(fontNamed: "Montserrat Light")
        let diamondIcon3 = SKSpriteNode(imageNamed: "diamond-icon")
        diamondCount3.text = "x\(PRICE_OF_X2)"
        diamondCount3.fontSize = 55
        diamondCount3.fontColor = SKColor.white
        diamondCount3.position = CGPoint(x: self.size.width * (2 / 3) + diamondIcon3.frame.width / 2, y: self.size.height * 0.41)
        diamondCount3.zPosition = 2
        diamondCount3.alpha = 0
        self.addChild(diamondCount3)
        
        diamondIcon3.position = CGPoint(x: self.size.width * (2 / 3) - diamondCount3.frame.width / 2, y: self.size.height * 0.42)
        diamondIcon3.zPosition = 2
        diamondIcon3.alpha = 0
        diamondIcon3.setScale(0.75)
        self.addChild(diamondIcon3)
        
        
        
        bombButton.position = CGPoint(x: self.size.width / 3, y: self.size.height * 0.3)
        bombButton.zPosition = 2
        bombButton.name = "bombButton"
        bombButton.alpha = 0
        self.addChild(bombButton)
        
        let bombCountBg = SKSpriteNode(imageNamed: "counter-bg")
        bombCountBg.position = CGPoint(x: bombButton.position.x + bombButton.frame.width / 2 - 30, y: bombButton.position.y + 90)
        bombCountBg.zPosition = 3
        bombCountBg.alpha = 0
        self.addChild(bombCountBg)
        
        bombCountLabel.text = "\(bombItemCount)"
        bombCountLabel.fontSize = 55
        bombCountLabel.fontColor = SKColor.white
        bombCountLabel.position = CGPoint(x: bombCountBg.position.x, y: bombCountBg.position.y - bombCountLabel.frame.height / 2)
        bombCountLabel.zPosition = 4
        bombCountLabel.alpha = 0
        self.addChild(bombCountLabel)
        
        let diamondCount4 = SKLabelNode(fontNamed: "Montserrat Light")
        let diamondIcon4 = SKSpriteNode(imageNamed: "diamond-icon")
        diamondCount4.text = "x\(PRICE_OF_BOMB)"
        diamondCount4.fontSize = 55
        diamondCount4.fontColor = SKColor.white
        diamondCount4.position = CGPoint(x: self.size.width / 3 + diamondIcon4.frame.width / 2, y: self.size.height * 0.21)
        diamondCount4.zPosition = 2
        diamondCount4.alpha = 0
        self.addChild(diamondCount4)
        
        diamondIcon4.position = CGPoint(x: self.size.width / 3 - diamondCount4.frame.width / 2, y: self.size.height * 0.22)
        diamondIcon4.zPosition = 2
        diamondIcon4.alpha = 0
        diamondIcon4.setScale(0.75)
        self.addChild(diamondIcon4)
        
        
        
        rowButton.position = CGPoint(x: self.size.width *  (2 / 3), y: self.size.height * 0.3)
        rowButton.zPosition = 2
        rowButton.name = "rowButton"
        rowButton.alpha = 0
        self.addChild(rowButton)
        
        let rowCountBg = SKSpriteNode(imageNamed: "counter-bg")
        rowCountBg.position = CGPoint(x: rowButton.position.x + rowButton.frame.width / 2 - 30, y: rowButton.position.y + 90)
        rowCountBg.zPosition = 3
        rowCountBg.alpha = 0
        self.addChild(rowCountBg)
        
        rowCountLabel.text = "\(rowItemCount)"
        rowCountLabel.fontSize = 55
        rowCountLabel.fontColor = SKColor.white
        rowCountLabel.position = CGPoint(x: rowCountBg.position.x, y: rowCountBg.position.y - rowCountLabel.frame.height / 2)
        rowCountLabel.zPosition = 4
        rowCountLabel.alpha = 0
        self.addChild(rowCountLabel)
        
        let diamondCount5 = SKLabelNode(fontNamed: "Montserrat Light")
        let diamondIcon5 = SKSpriteNode(imageNamed: "diamond-icon")
        diamondCount5.text = "x\(PRICE_OF_ROW)"
        diamondCount5.fontSize = 55
        diamondCount5.fontColor = SKColor.white
        diamondCount5.position = CGPoint(x: self.size.width * (2 / 3) + diamondIcon5.frame.width / 2, y: self.size.height * 0.21)
        diamondCount5.zPosition = 2
        diamondCount5.alpha = 0
        self.addChild(diamondCount5)
        
        diamondIcon5.position = CGPoint(x: self.size.width * (2 / 3) - diamondCount5.frame.width / 2, y: self.size.height * 0.22)
        diamondIcon5.zPosition = 2
        diamondIcon5.alpha = 0
        diamondIcon5.setScale(0.75)
        self.addChild(diamondIcon5)
        
        

        let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
        let moveDownAction = SKAction.moveBy(x: 0, y: -30, duration: 0.2)
        let fadeMoveGroup = SKAction.group([fadeInAction, moveDownAction])
        backButton.run(fadeInAction)
        diamondIcon.run(fadeInAction)
        diamondCount.run(fadeInAction)
        buyButton1.run(fadeMoveGroup)
        buyButton2.run(fadeMoveGroup)
        buyButton3.run(fadeMoveGroup)
        buyButton1PriceLabel.run(fadeMoveGroup)
        buyButton2PriceLabel.run(fadeMoveGroup)
        buyButton3PriceLabel.run(fadeMoveGroup)
        diamondIcon2.run(fadeMoveGroup)
        diamondCount2.run(fadeMoveGroup)
        diamondIcon3.run(fadeMoveGroup)
        diamondCount3.run(fadeMoveGroup)
        diamondIcon4.run(fadeMoveGroup)
        diamondCount4.run(fadeMoveGroup)
        diamondIcon5.run(fadeMoveGroup)
        diamondCount5.run(fadeMoveGroup)
        rowButton.run(fadeMoveGroup)
        bombButton.run(fadeMoveGroup)
        x2Button.run(fadeMoveGroup)
        targetButton.run(fadeMoveGroup)
        targetCountBg.run(fadeMoveGroup)
        x2CountBg.run(fadeMoveGroup)
        bombCountBg.run(fadeMoveGroup)
        rowCountBg.run(fadeMoveGroup)
        targetCountLabel.run(fadeMoveGroup)
        x2CountLabel.run(fadeMoveGroup)
        bombCountLabel.run(fadeMoveGroup)
        rowCountLabel.run(fadeMoveGroup)
    }
    
    func playButtonClick() {
        if UserDefaults().bool(forKey: "vibrateEnabledSaved") == true {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
        
        if UserDefaults().bool(forKey: "soundEnabledSaved") == true {
            // play sound
        }
    }
    
    func updateDiamonds(amount: Int) {
        diamondsCount += amount
        UserDefaults().set(diamondsCount, forKey: "diamondsCountSaved")
        diamondCount.text = "\(diamondsCount)"
        diamondCount.position = CGPoint(x: self.size.width - diamondCount.frame.width - 275, y: self.size.height - 175)
        diamondIcon.position = CGPoint(x: self.size.width - diamondCount.frame.width - 350, y: self.size.height - 150)
        
        buttonInteraction(node: diamondCount)
    }
    
    func changeColorDiamonds() {
        let fontColorRed = SKAction.run{
            self.diamondCount.fontColor = SKColor(red:0.93, green:0.19, blue:0.06, alpha: 1)
        }
        let fontColorWhite = SKAction.run{
            self.diamondCount.fontColor = SKColor.white
        }
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.05), fontColorRed, SKAction.wait(forDuration: 0.15), fontColorWhite]))
    }
    
    func handleBuyTargetItem() {
        if targetItemCount >= 99 {
            // make text red in original circle
            return
        }
        
        if diamondsCount - PRICE_OF_TARGET < 0 || diamondsCount <= 0 {
            buttonInteraction(node: diamondCount)
            if diamondsCount - PRICE_OF_TARGET < 0 {
                changeColorDiamonds()
            }
            return
        }
        
        playButtonClick()
        
        targetItemCount += 1
        UserDefaults().set(targetItemCount, forKey: "targetItemCountSaved")
        targetCountLabel.text = "\(targetItemCount)"
        updateDiamonds(amount: -PRICE_OF_TARGET)

        buttonInteraction(node: targetCountLabel)
        buttonInteraction(node: targetButton)
    }
    
    func handleBuyX2Item() {
        if x2ItemCount >= 99 {
            return
        }
        
        if diamondsCount - PRICE_OF_X2 < 0 || diamondsCount <= 0 {
            buttonInteraction(node: diamondCount)
            if diamondsCount - PRICE_OF_X2 < 0 {
                changeColorDiamonds()
            }
            return
        }
        
        playButtonClick()
        
        x2ItemCount += 1
        UserDefaults().set(x2ItemCount, forKey: "x2ItemCountSaved")
        x2CountLabel.text = "\(x2ItemCount)"
        updateDiamonds(amount: -PRICE_OF_X2)
        
        buttonInteraction(node: x2CountLabel)
        buttonInteraction(node: x2Button)
    }
    
    func handleBuyBombItem() {
        if bombItemCount >= 99 {
            return
        }
        
        if diamondsCount - PRICE_OF_BOMB < 0 || diamondsCount <= 0 {
            buttonInteraction(node: diamondCount)
            if diamondsCount - PRICE_OF_BOMB < 0 {
                changeColorDiamonds()
            }
            return
        }
        
        playButtonClick()

        bombItemCount += 1
        UserDefaults().set(bombItemCount, forKey: "bombItemCountSaved")
        bombCountLabel.text = "\(bombItemCount)"
        updateDiamonds(amount: -PRICE_OF_BOMB)
        
        buttonInteraction(node: bombCountLabel)
        buttonInteraction(node: bombButton)
    }
    
    func handleBuyRowItem() {
        if rowItemCount >= 99 {
            return
        }
        
        if diamondsCount - PRICE_OF_ROW < 0 || diamondsCount <= 0 {
            buttonInteraction(node: diamondCount)
            if diamondsCount - PRICE_OF_ROW < 0 {
                changeColorDiamonds()
            }
            return
        }
        
        playButtonClick()
        
        rowItemCount += 1
        UserDefaults().set(rowItemCount, forKey: "rowItemCountSaved")
        rowCountLabel.text = "\(rowItemCount)"
        updateDiamonds(amount: -PRICE_OF_ROW)
        
        buttonInteraction(node: rowButton)
        buttonInteraction(node: rowCountLabel)
    }
    
    func buttonInteraction(node: AnyObject) {
        let scaleUpAction = SKAction.scale(to: 1.2, duration: 0.1)
        let scaleDownAction = SKAction.scale(to: 1.0, duration: 0.1)
        let scaleSequence = SKAction.sequence([scaleUpAction, scaleDownAction])
        
        node.run(scaleSequence)
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
                case "buyButton1":
                    playButtonClick()
                    buttonInteraction(node: buyButton1)
                    updateDiamonds(amount: 25)
                    
                case "buyButton2":
                    playButtonClick()
                    buttonInteraction(node: buyButton2)
                    updateDiamonds(amount: 50)
                    
                case "buyButton3":
                    playButtonClick()
                    buttonInteraction(node: buyButton3)
                    updateDiamonds(amount: 100)
                    
                case "targetButton":
                    handleBuyTargetItem()
                    
                case "rowButton":
                    handleBuyRowItem()
                    
                case "x2Button":
                    handleBuyX2Item()
                    
                case "bombButton":
                    handleBuyBombItem()
                    
                case "backButton":
                    let sceneToMoveTo = MainMenuScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
                    previousScene = scenes.storeMenu
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
