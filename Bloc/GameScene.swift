//
//  GameScene.swift
//  Bloc
//
//  Created by Andrew Johnston on 3/17/18.
//  Copyright © 2018 Andrew Johnston. All rights reserved.
//

import SpriteKit
var gameLevel: Int = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    let backgroundBubblesSm1 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesSm2 = SKSpriteNode(imageNamed: "background-bubbles-small")
    let backgroundBubblesMd1 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesMd2 = SKSpriteNode(imageNamed: "background-bubbles-medium")
    let backgroundBubblesLg1 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let backgroundBubblesLg2 = SKSpriteNode(imageNamed: "background-bubbles-large")
    let background = SKSpriteNode(imageNamed: "background")
    let backgroundFlipped = SKSpriteNode(imageNamed: "background-flipped")
    
    let levelLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let diamondCount = SKLabelNode(fontNamed: "Montserrat Light")
    let diamondIcon = SKSpriteNode(imageNamed: "diamond-icon")
    let pauseButton = SKSpriteNode(imageNamed: "pause")
    
    let rowCountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let targetCountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let x2CountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    let bombCountLabel = SKLabelNode(fontNamed: "Montserrat Light")
    
    var targetItemCount = UserDefaults().integer(forKey: "targetItemCountSaved")
    var bombItemCount = UserDefaults().integer(forKey: "bombItemCountSaved")
    var x2ItemCount = UserDefaults().integer(forKey: "x2ItemCountSaved")
    var rowItemCount = UserDefaults().integer(forKey: "rowItemCountSaved")
    
    let bombButton = UserDefaults().integer(forKey: "bombItemCountSaved") > 0 ? SKSpriteNode(imageNamed: "bomb-icon") : SKSpriteNode(imageNamed: "bomb-icon-disabled")
    let targetButton = UserDefaults().integer(forKey: "targetItemCountSaved") > 0 ? SKSpriteNode(imageNamed: "target-icon") : SKSpriteNode(imageNamed: "target-icon-disabled")
    let x2Button = UserDefaults().integer(forKey: "x2ItemCountSaved") > 0 ? SKSpriteNode(imageNamed: "x2-icon") : SKSpriteNode(imageNamed: "x2-icon-disabled")
    let rowButton = UserDefaults().integer(forKey: "rowItemCountSaved") > 0 ? SKSpriteNode(imageNamed: "row-icon") : SKSpriteNode(imageNamed: "row-icon-disabled")
    
    var highScore = UserDefaults().integer(forKey: "highScoreSaved")
    var restartConfirmButtonOpen = false
    let player = SKShapeNode(circleOfRadius: 25)
    
    var ballVelocity = CGVector(dx: 0, dy: 0)
    var initialBallVelocity = CGVector(dx: 0, dy: 0)
    var touchStart = CGPoint()
    var newPosition = CGPoint()
    var aimLineLength = CGFloat()
    
    let ballSpeed = CGFloat(250)
    
    var blocks = [[Int]](repeating: [Int](repeating: 0, count: 7), count:7)
    
    enum activeItemState: String {
        case bomb
        case x2
        case row
        case target
        case none
    }
    var currentActiveItem = activeItemState.none

    let gameArea: CGRect
    
    enum gameState: String {
        case readyToShoot
        case gameInProgress
        case paused
    }
    var currentGameState = gameState.readyToShoot
    var previousGameState = gameState.readyToShoot
    
    struct PhysicsCategories {
        static let None : UInt32 = 0
        static let SceneBoundaryTop : UInt32 = 0b1  //1
        static let SceneBoundaryBottom : UInt32 = 0b10 //2
        static let Player : UInt32 = 0b100 //4
        static let Block : UInt32 = 0b1000
    }
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: gameArea)
        borderBody.friction = 0
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        // Pauses the game when the app is moved to the background
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil)
        UIApplication.shared.isIdleTimerDisabled = true
        
        currentScene = scenes.game
        self.physicsWorld.contactDelegate = self
        
        background.position = CGPoint(x: self.size.width / 2, y: currentScene != previousScene ? self.size.height / 2 - 1 : self.size.height - 1)
        background.zPosition = 0
        background.name = "background"
        background.size = self.size
        background.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.addChild(background)
        
        backgroundFlipped.position = CGPoint(x: self.size.width / 2, y: currentScene != previousScene ? -self.size.height / 2 : 0 )
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
        
        let topBanner = SKShapeNode(rectOf: CGSize(width: self.size.width, height: 1))
        topBanner.position = CGPoint(x: self.size.width / 2, y: self.size.height - 150)
        topBanner.zPosition = 3
        topBanner.strokeColor = SKColor(red:0.80, green:0.80, blue:0.80, alpha: 0.7)
        topBanner.alpha = 0
        topBanner.physicsBody = SKPhysicsBody(rectangleOf: topBanner.frame.size)
        topBanner.physicsBody!.allowsRotation = false
        topBanner.physicsBody!.friction = 0.0
        topBanner.physicsBody!.affectedByGravity = false
        topBanner.physicsBody!.isDynamic = false
        topBanner.name = "topBanner"
        topBanner.physicsBody!.categoryBitMask = PhysicsCategories.SceneBoundaryTop
        self.addChild(topBanner)
        
        let bottomBanner = SKShapeNode(rectOf: CGSize(width: self.size.width, height: 1))
        bottomBanner.position = CGPoint(x: self.size.width / 2, y: 200)
        bottomBanner.zPosition = 3
        bottomBanner.strokeColor = SKColor(red:0.80, green:0.80, blue:0.80, alpha: 1.0)
        bottomBanner.alpha = 0
        bottomBanner.physicsBody = SKPhysicsBody(rectangleOf: bottomBanner.frame.size)
        bottomBanner.physicsBody!.allowsRotation = false
        bottomBanner.physicsBody!.friction = 0.0
        bottomBanner.physicsBody!.affectedByGravity = false
        bottomBanner.physicsBody!.isDynamic = false
        bottomBanner.name = "bottomBanner"
        bottomBanner.physicsBody!.categoryBitMask = PhysicsCategories.SceneBoundaryBottom
        bottomBanner.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(bottomBanner)
        
        pauseButton.position = CGPoint(x: gameArea.minX + 100, y: self.size.height - 75)
        pauseButton.zPosition = 3
        pauseButton.name = "pauseButton"
        pauseButton.alpha = 0
        self.addChild(pauseButton)
        
        diamondCount.text = "\(UserDefaults().integer(forKey: "diamondsCountSaved"))"
        diamondCount.fontSize = 70
        diamondCount.fontColor = SKColor.white
        diamondCount.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        diamondCount.position = CGPoint(x: self.size.width / 2 - diamondCount.frame.width / 2 + (75 / 2), y: self.size.height - 105)
        diamondCount.zPosition = 3
        diamondCount.alpha = 0
        self.addChild(diamondCount)
        
        diamondIcon.position = CGPoint(x: self.size.width / 2 - diamondCount.frame.width / 2 - (75 / 2), y: self.size.height - 80)
        diamondIcon.zPosition = 3
        diamondIcon.setScale(0.9)
        diamondIcon.alpha = 0
        self.addChild(diamondIcon)
        
        levelLabel.text = "\(gameLevel)"
        levelLabel.fontSize = 70
        levelLabel.fontColor = SKColor.white
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.position = CGPoint(x: gameArea.maxX - levelLabel.frame.width - 50, y: self.size.height - 100)
        levelLabel.zPosition = 3
        levelLabel.alpha = 0
        self.addChild(levelLabel)
        
        
        
        bombButton.position = CGPoint(x: self.size.width / 2 - (gameArea.width / 4 - (gameArea.width / 4) / 2), y: 90)
        bombButton.zPosition = 3
        bombButton.name = "bombButton"
        bombButton.anchorPoint = CGPoint(x: 0.5, y: 0.45)
        bombButton.alpha = 0
        self.addChild(bombButton)
        
        let bombCountBg = SKSpriteNode(imageNamed: "counter-bg")
        bombCountBg.position = CGPoint(x: bombButton.position.x + bombButton.frame.width / 2 + 10, y: bombButton.position.y + 55)
        bombCountBg.zPosition = 3
        bombCountBg.setScale(0.7)
        bombCountBg.alpha = 0
        self.addChild(bombCountBg)
        
        bombCountLabel.text = "\(bombItemCount)"
        bombCountLabel.fontSize = 35
        bombCountLabel.fontColor = SKColor.white
        bombCountLabel.position = CGPoint(x: bombCountBg.position.x, y: bombCountBg.position.y - bombCountLabel.frame.height / 2)
        bombCountLabel.zPosition = 4
        bombCountLabel.alpha = 0
        self.addChild(bombCountLabel)
        
        
        
        targetButton.position = CGPoint(x: self.size.width / 2 - (gameArea.width / 4 + (gameArea.width / 4) / 2), y: 90)
        targetButton.zPosition = 3
        targetButton.name = "targetButton"
        targetButton.anchorPoint = CGPoint(x: 0.5, y: 0.45)
        targetButton.alpha = 0
        self.addChild(targetButton)
        
        let targetCountBg = SKSpriteNode(imageNamed: "counter-bg")
        targetCountBg.position = CGPoint(x: targetButton.position.x + targetButton.frame.width / 2 + 10, y: targetButton.position.y + 55)
        targetCountBg.zPosition = 3
        targetCountBg.setScale(0.7)
        targetCountBg.alpha = 0
        self.addChild(targetCountBg)
        
        targetCountLabel.text = "\(targetItemCount)"
        targetCountLabel.fontSize = 35
        targetCountLabel.fontColor = SKColor.white
        targetCountLabel.position = CGPoint(x: targetCountBg.position.x, y: targetCountBg.position.y - targetCountLabel.frame.height / 2)
        targetCountLabel.zPosition = 4
        targetCountLabel.alpha = 0
        self.addChild(targetCountLabel)
        
        
        
        x2Button.position = CGPoint(x: self.size.width / 2 + (gameArea.width / 4 - (gameArea.width / 4) / 2), y: 90)
        x2Button.zPosition = 3
        x2Button.name = "x2Button"
        x2Button.anchorPoint = CGPoint(x: 0.5, y: 0.45)
        x2Button.alpha = 0
        self.addChild(x2Button)
        
        let x2CountBg = SKSpriteNode(imageNamed: "counter-bg")
        x2CountBg.position = CGPoint(x: x2Button.position.x + x2Button.frame.width / 2 + 10, y: x2Button.position.y + 55)
        x2CountBg.zPosition = 3
        x2CountBg.setScale(0.7)
        x2CountBg.alpha = 0
        self.addChild(x2CountBg)
        
        x2CountLabel.text = "\(x2ItemCount)"
        x2CountLabel.fontSize = 35
        x2CountLabel.fontColor = SKColor.white
        x2CountLabel.position = CGPoint(x: x2CountBg.position.x, y: x2CountBg.position.y - x2CountLabel.frame.height / 2)
        x2CountLabel.zPosition = 4
        x2CountLabel.alpha = 0
        self.addChild(x2CountLabel)
        
        
        
        rowButton.position = CGPoint(x: self.size.width / 2 + (gameArea.width / 4 + (gameArea.width / 4) / 2), y: 90)
        rowButton.zPosition = 3
        rowButton.name = "rowButton"
        rowButton.anchorPoint = CGPoint(x: 0.5, y: 0.45)
        rowButton.alpha = 0
        self.addChild(rowButton)
        
        let rowCountBg = SKSpriteNode(imageNamed: "counter-bg")
        rowCountBg.position = CGPoint(x: rowButton.position.x + rowButton.frame.width / 2 + 10, y: rowButton.position.y + 55)
        rowCountBg.zPosition = 3
        rowCountBg.setScale(0.7)
        rowCountBg.alpha = 0
        self.addChild(rowCountBg)
        
        rowCountLabel.text = "\(rowItemCount)"
        rowCountLabel.fontSize = 35
        rowCountLabel.fontColor = SKColor.white
        rowCountLabel.position = CGPoint(x: rowCountBg.position.x, y: rowCountBg.position.y - rowCountLabel.frame.height / 2)
        rowCountLabel.zPosition = 4
        rowCountLabel.alpha = 0
        self.addChild(rowCountLabel)
        
        
        
        
        
//        let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
        let fadeMoveAction = SKAction.fadeIn(withDuration: 0.2)
        let moveUpAction = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 0.2)
        let fadeMoveUp = SKAction.group([fadeMoveAction, moveUpAction])
        let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -200), duration: 0.2)
        let fadeInAction = currentScene == previousScene ? SKAction.fadeIn(withDuration: 0.2) : SKAction.sequence([moveDown, fadeMoveUp])
        
        pauseButton.run(fadeInAction)
        topBanner.run(fadeInAction)
        bottomBanner.run(fadeInAction)
        pauseButton.run(fadeInAction)
        diamondCount.run(fadeInAction)
        diamondIcon.run(fadeInAction)
        bombButton.run(fadeInAction)
        bombCountBg.run(fadeInAction)
        bombCountLabel.run(fadeInAction)
        targetButton.run(fadeInAction)
        targetCountBg.run(fadeInAction)
        targetCountLabel.run(fadeInAction)
        rowButton.run(fadeInAction)
        rowCountBg.run(fadeInAction)
        rowCountLabel.run(fadeInAction)
        x2Button.run(fadeInAction)
        x2CountLabel.run(fadeInAction)
        x2CountBg.run(fadeInAction)
        levelLabel.run(fadeInAction)
        
        if currentScene != previousScene {
            let moveUpBg = SKAction.move(by: CGVector(dx: 0, dy: self.size.height / 2), duration: 0.2)
            background.run(moveUpBg)
            backgroundFlipped.run(moveUpBg)
        }
        
        if UserDefaults().bool(forKey: "gameSavedData") == true {
            loadGame()
        } else {
            initializeGame()
        }
    }
    
    @objc func willResignActive(_ notification: Notification) {
        pauseGame()
    }
    
    func toggleSelectionOfItem(item: String) {
        bombButton.texture = bombItemCount > 0 ? SKTexture(imageNamed: "bomb-icon") : SKTexture(imageNamed: "bomb-icon-disabled")
        x2Button.texture = x2ItemCount > 0 ? SKTexture(imageNamed: "x2-icon") : SKTexture(imageNamed: "x2-icon-disabled")
        rowButton.texture = rowItemCount > 0 ? SKTexture(imageNamed: "row-icon") : SKTexture(imageNamed: "row-icon-disabled")
        targetButton.texture = targetItemCount > 0 ? SKTexture(imageNamed: "target-icon") : SKTexture(imageNamed: "target-icon-disabled")
        bombButton.run(SKAction.scale(to: 1, duration: 0.2))
        x2Button.run(SKAction.scale(to: 1, duration: 0.2))
        rowButton.run(SKAction.scale(to: 1, duration: 0.2))
        targetButton.run(SKAction.scale(to: 1, duration: 0.2))
        player.fillColor = SKColor.white
        
        switch item {
        case "bombButton":
            if currentActiveItem == activeItemState.bomb {
                currentActiveItem = activeItemState.none
            } else {
                currentActiveItem = activeItemState.bomb
                bombButton.run(SKAction.scale(to: 1.5, duration: 0.2))
                bombButton.texture = SKTexture(imageNamed: "bomb-icon-color")
                player.fillColor = SKColor(red: 1, green: 0.5765, blue: 0, alpha: 1)
            }
            
        case "x2Button":
            if currentActiveItem == activeItemState.x2 {
                currentActiveItem = activeItemState.none
            } else {
                currentActiveItem = activeItemState.x2
                x2Button.run(SKAction.scale(to: 1.5, duration: 0.2))
                x2Button.texture = SKTexture(imageNamed: "x2-icon-color")
                player.fillColor = SKColor(red: 0.0235, green: 0.9765, blue: 0.0235, alpha: 1)
            }
            
        case "rowButton":
            if currentActiveItem == activeItemState.row {
                currentActiveItem = activeItemState.none
            } else {
                currentActiveItem = activeItemState.row
                rowButton.run(SKAction.scale(to: 1.5, duration: 0.2))
                rowButton.texture = SKTexture(imageNamed: "row-icon-color")
                player.fillColor = SKColor(red: 0.9294, green: 0.2314, blue: 0.0941, alpha: 1)
            }
            
        case "targetButton":
            if currentActiveItem == activeItemState.target {
                currentActiveItem = activeItemState.none
            } else {
                currentActiveItem = activeItemState.target
                targetButton.run(SKAction.scale(to: 1.5, duration: 0.2))
                targetButton.texture = SKTexture(imageNamed: "target-icon-color")
                player.fillColor = SKColor(red: 1, green: 1, blue: 0, alpha: 1)
            }
            
        default:
            break
        }
    }
    
    var arrayOfVelocities: [CGVector] = []
    
    func pauseGame() {
        if currentGameState == gameState.gameInProgress {
            ballVelocity = player.physicsBody!.velocity
        }
        player.physicsBody!.isDynamic = false
        player.alpha = 0.3
        
        self.enumerateChildNodes(withName: "ball") {
            ball, stop in
            // The velocity needs to be dynamically saved
            self.arrayOfVelocities.append(ball.physicsBody!.velocity)
            ball.physicsBody!.isDynamic = false
            ball.alpha = 0.3
        }
        
        previousGameState = currentGameState
        currentGameState = gameState.paused
//        makeDiamondsVisible()
        pauseButton.texture = SKTexture(imageNamed: "play-icon")
        
        let soundButton = UserDefaults().bool(forKey: "soundEnabledSaved") ? SKSpriteNode(imageNamed: "sound") : SKSpriteNode(imageNamed: "sound-disabled")
        soundButton.position = CGPoint(x: gameArea.minX + 110, y: self.size.height - 250)
        soundButton.zPosition = 21
        soundButton.name = "soundButton"
        soundButton.setScale(0.7)
        soundButton.alpha = 0
        self.addChild(soundButton)
        
        let vibrateButton = UserDefaults().bool(forKey: "vibrateEnabledSaved") ? SKSpriteNode(imageNamed: "vibrate") : SKSpriteNode(imageNamed: "vibrate-disabled")
        vibrateButton.position = CGPoint(x: gameArea.minX + 110, y: soundButton.position.y - soundButton.frame.height - 50)
        vibrateButton.zPosition = 21
        vibrateButton.name = "vibrateButton"
        vibrateButton.setScale(0.7)
        vibrateButton.alpha = 0
        self.addChild(vibrateButton)
        
        let restartButton = SKSpriteNode(imageNamed: "restart")
        restartButton.position = CGPoint(x: gameArea.minX + 110, y: vibrateButton.position.y - vibrateButton.frame.height - 50)
        restartButton.zPosition = 21
        restartButton.name = "restartButton"
        restartButton.setScale(0.7)
        restartButton.alpha = 0
        self.addChild(restartButton)
        
        let homeButton = SKSpriteNode(imageNamed: "home")
        homeButton.position = CGPoint(x: gameArea.minX + 110, y: restartButton.position.y - restartButton.frame.height - 50)
        homeButton.zPosition = 21
        homeButton.name = "homeButton"
        homeButton.setScale(0.7)
        homeButton.alpha = 0
        self.addChild(homeButton)
        
        let trophyIcon = SKSpriteNode(imageNamed: "trophy-icon")
        trophyIcon.position = CGPoint(x: gameArea.maxX - 75, y: self.size.height - 225)
        trophyIcon.zPosition = 21
        trophyIcon.alpha = 0
        trophyIcon.name = "trophyIcon"
        self.addChild(trophyIcon)
        
        let highScoreLabel = SKLabelNode(fontNamed: "Montserrat Light")
        highScoreLabel.text = "\(highScore)"
        highScoreLabel.position = CGPoint(x: trophyIcon.position.x - 60, y: trophyIcon.position.y - 27)
        highScoreLabel.fontSize = 70
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        highScoreLabel.zPosition = 21
        highScoreLabel.alpha = 0
        highScoreLabel.name = "highScoreLabel"
        self.addChild(highScoreLabel)
        
        let fadeMoveGroup: SKAction
        let diamondsVisible = SKAction.run{
            self.makeDiamondsVisible()
        }
        
        if UserDefaults().bool(forKey: "gameSavedData") == true {
            let fadeMoveAction = SKAction.fadeIn(withDuration: 0.2)
            let moveUpAction = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 0.2)
            let fadeMoveUp = SKAction.group([fadeMoveAction, moveUpAction])
            let moveDown = SKAction.move(by: CGVector(dx: 0, dy: -200), duration: 0.2)
            
            fadeMoveGroup = SKAction.sequence([moveDown, fadeMoveUp, diamondsVisible])
        } else {
            let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
            let moveDownAction = SKAction.moveBy(x: 0, y: -30, duration: 0.2)
            fadeMoveGroup = SKAction.group([fadeInAction, moveDownAction, diamondsVisible])
        }
        
        soundButton.run(fadeMoveGroup)
        vibrateButton.run(fadeMoveGroup)
        restartButton.run(fadeMoveGroup)
        homeButton.run(fadeMoveGroup)
        trophyIcon.run(fadeMoveGroup)
        highScoreLabel.run(fadeMoveGroup)
    }
    
    func toggleRestartConfirm() {
        if restartConfirmButtonOpen == true {
            self.childNode(withName: "confirmButton")?.removeFromParent()
            restartConfirmButtonOpen = false
        } else {
            let confirmButton = SKSpriteNode(imageNamed: "confirm")
            confirmButton.setScale(0.7)
            confirmButton.position = CGPoint(x: gameArea.minX + 160 + confirmButton.frame.width, y: self.size.height - confirmButton.frame.height * 3 - 205)
            confirmButton.zPosition = 21
            confirmButton.name = "confirmButton"
            self.addChild(confirmButton)
            
            restartConfirmButtonOpen = true
        }
    }
    
    
    func resumeGame() {
        currentGameState = previousGameState
        player.physicsBody!.isDynamic = true
        player.alpha = 1
        
        self.enumerateChildNodes(withName: "ball") {
            ball, stop in
            ball.physicsBody!.isDynamic = true
            
            if (self.previousGameState == gameState.gameInProgress) {
                let v = self.arrayOfVelocities.removeFirst()
                
                // this accounts if the ball is spawned by not yet fired
                if v == CGVector(dx: 0.0, dy: 0.0) {
                    ball.physicsBody!.applyImpulse(self.initialBallVelocity)
                } else {
                    ball.physicsBody!.velocity = v
                }
                ball.alpha = 1
            }
        }
        
        if (previousGameState == gameState.gameInProgress) {
            player.physicsBody!.velocity = ballVelocity
            
            spawnBalls(location: spawnLocation, velocity: initialBallVelocity)
        }
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.01)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        
        self.childNode(withName: "soundButton")?.run(deleteSequence)
        self.childNode(withName: "vibrateButton")?.run(deleteSequence)
        self.childNode(withName: "homeButton")?.run(deleteSequence)
        self.childNode(withName: "restartButton")?.run(deleteSequence)
        self.childNode(withName: "confirmButton")?.run(deleteSequence)
        self.childNode(withName: "trophyIcon")?.run(deleteSequence)
        self.childNode(withName: "highScoreLabel")?.run(deleteSequence)
        
        pauseButton.texture = SKTexture(imageNamed: "pause")
    }
    
    var diamondsInactivityTimer = 0
    
    func fadeAndMoveDiamonds() {
        let moveUpAction = SKAction.moveBy(x: 0, y: 300, duration: 0.3)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.01)
        let moveDownAction = SKAction.moveBy(x: 0, y: -300, duration: 0.01)
        let fadeMoveSequence = SKAction.sequence([moveUpAction, fadeOutAction, moveDownAction])
        diamondCount.run(fadeMoveSequence)
        diamondIcon.run(fadeMoveSequence)
        
        diamondsInactivityTimer = 0
    }
    
    func makeDiamondsVisible() {
        diamondCount.alpha = 1
        diamondIcon.alpha = 1
        
        diamondsInactivityTimer = 0
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
        
        diamondsInactivityTimer += 1
        if diamondsInactivityTimer >= 200 && currentGameState != gameState.paused {
            fadeAndMoveDiamonds()
        }
    }
    
    func loadGame() {
        gameLevel = UserDefaults().integer(forKey: "gameLevelSaved")
//        currentGameState = GameScene.gameState(rawValue: (UserDefaults().value(forKey: "currentGameStateSaved") as! String))!
        currentActiveItem = GameScene.activeItemState(rawValue: UserDefaults().value(forKey: "currentActiveItemSaved") as! String)!
        
        // this threw an error. Unexpectedly found nil while unwrapping an Optional value
//        blocks = UserDefaults().array(forKey: "blocksSaved") as! [[Int]]
        currentGameState = gameState.readyToShoot
        ballsSpawned = 0
        ballsInPlay = 0
        
        levelLabel.text = "\(gameLevel)"
        
        if currentActiveItem != activeItemState.none {
            switch currentActiveItem {
            case activeItemState.bomb:
                toggleSelectionOfItem(item: "bombButton")
            case activeItemState.row:
                toggleSelectionOfItem(item: "rowButton")
            case activeItemState.target:
                toggleSelectionOfItem(item: "targetButton")
            case activeItemState.x2:
                toggleSelectionOfItem(item: "x2Button")
            default:
                break
            }
        }
        
        player.fillColor = SKColor.white
        player.strokeColor = SKColor.clear
        player.position = CGPoint(x: self.size.width / 2, y: 185 + player.frame.height)
        player.zPosition = 11
        player.name = "player"
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.physicsBody!.friction = 0.0
        player.physicsBody!.allowsRotation = false
        player.physicsBody!.restitution = 1
        player.physicsBody!.linearDamping = 0
        player.physicsBody!.angularDamping = 0
        player.physicsBody!.isDynamic = true
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.contactTestBitMask = PhysicsCategories.SceneBoundaryBottom
        player.physicsBody!.collisionBitMask = PhysicsCategories.SceneBoundaryBottom | PhysicsCategories.SceneBoundaryTop
        self.addChild(player)
        
        // Rather than calling spawnBlocks here, set the blocks array to equal the UserDefaults, then display it
//        spawnBlocks()
        pauseGame()
    }
    
    func initializeGame() {
        gameLevel = 1
        levelLabel.text = "\(gameLevel)"
        
        currentActiveItem = activeItemState.none
        
        player.fillColor = SKColor.white
        player.strokeColor = SKColor.clear
        player.position = CGPoint(x: self.size.width / 2, y: 185 + player.frame.height)
        player.zPosition = 11
        player.name = "player"
        player.alpha = 0
        player.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        player.physicsBody!.friction = 0.0
        player.physicsBody!.allowsRotation = false
        player.physicsBody!.restitution = 1
        player.physicsBody!.linearDamping = 0
        player.physicsBody!.angularDamping = 0
        player.physicsBody!.isDynamic = true
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.contactTestBitMask = PhysicsCategories.SceneBoundaryBottom
        player.physicsBody!.collisionBitMask = PhysicsCategories.SceneBoundaryBottom | PhysicsCategories.SceneBoundaryTop
        self.addChild(player)
        
        spawnBlocks()
        
        let touch = SKSpriteNode(imageNamed: "touch")
        touch.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + touch.frame.height)
        touch.zPosition = 3
        touch.name = "touch-tutorial"
        touch.alpha = 0
        self.addChild(touch)
        
        let moveUpAction = SKAction.move(by: CGVector(dx: 0, dy: -400), duration: 1)
        let moveDownAction = SKAction.move(by: CGVector(dx: 0, dy: 400), duration: 1)
        let moveSequence = SKAction.sequence([moveUpAction, moveDownAction])
        let bounceForeverAction = SKAction.repeatForever(moveSequence)
        touch.run(bounceForeverAction)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.4)
        player.run(fadeInAction)
        touch.run(fadeInAction)
    }
    
    func saveGame() {
        UserDefaults().set(gameLevel, forKey: "gameLevelSaved")
        UserDefaults().set(currentActiveItem.rawValue, forKey: "currentActiveItemSaved")
        UserDefaults().set(currentGameState.rawValue, forKey: "currentGameStateSaved")
        UserDefaults().set(blocks, forKey: "blocksSaved")

        UserDefaults().set(targetItemCount, forKey: "targetItemCountSaved")
        UserDefaults().set(bombItemCount, forKey: "bombItemCountSaved")
        UserDefaults().set(x2ItemCount, forKey: "x2ItemCountSaved")
        UserDefaults().set(rowItemCount, forKey: "rowItemCountSaved")

        UserDefaults().set(true, forKey: "gameSavedData")
    }
    
    
    var ballsSpawned = 0
    var ballsInPlay = 0
    var spawnLocation = CGPoint(x: 0, y: 0)
    func spawnBalls(location: CGPoint, velocity: CGVector) {
        let amount = gameLevel
        
        if ballsSpawned >= amount || currentGameState == gameState.paused {
            return
        }
        
        let ball = SKShapeNode(circleOfRadius: 25)
        ball.fillColor = SKColor.white
        ball.strokeColor = SKColor.clear
        ball.position = location
        ball.zPosition = 11
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody!.friction = 0.0
        ball.physicsBody!.allowsRotation = false
        ball.physicsBody!.restitution = 1
        ball.physicsBody!.linearDamping = 0
        ball.physicsBody!.angularDamping = 0
        ball.physicsBody!.isDynamic = true
        ball.physicsBody!.categoryBitMask = PhysicsCategories.Player
        ball.physicsBody!.contactTestBitMask = PhysicsCategories.SceneBoundaryBottom
        ball.physicsBody!.collisionBitMask = PhysicsCategories.SceneBoundaryBottom | PhysicsCategories.SceneBoundaryTop
        self.addChild(ball)
        
        let applyImpulse = SKAction.run{
            ball.physicsBody!.applyImpulse(velocity)
        }
        let wait = SKAction.wait(forDuration: 0.1)
        let spawn = SKAction.run{
            self.ballsSpawned += 1
            self.ballsInPlay += 1
            self.spawnBalls(location: location, velocity: velocity)
        }
        
        self.run(SKAction.sequence([wait, applyImpulse, spawn]))
    }
    
    func fireBall(x: CGFloat, y: CGFloat) {
        spawnLocation = player.position
        ballVelocity = CGVector(dx: x, dy: y)
        initialBallVelocity = ballVelocity
        player.physicsBody!.applyImpulse(ballVelocity)
        
        ballsSpawned += 1
        ballsInPlay += 1
        
        spawnBalls(location: spawnLocation, velocity: ballVelocity)
        
        if currentActiveItem != activeItemState.none {
            switch currentActiveItem {
            case activeItemState.target:
                targetItemCount -= 1
                targetCountLabel.text = "\(targetItemCount)"
                
            case activeItemState.bomb:
                bombItemCount -= 1
                bombCountLabel.text = "\(bombItemCount)"
                
            case activeItemState.x2:
                x2ItemCount -= 1
                x2CountLabel.text = "\(x2ItemCount)"
                
            case activeItemState.row:
                rowItemCount -= 1
                rowCountLabel.text = "\(rowItemCount)"
                
            default:
                return
            }
        }
        
        saveGame()
        
        let tutorialNode = self.childNode(withName: "touch-tutorial")
        
        if tutorialNode != nil {
            tutorialNode?.removeFromParent()
        }
    }
    
    func createBlockNodes(rowArray: [[Int]]) {
        // take argument of rowArray, iterate through it
        print(rowArray)
        for i in 0...6 {
            if rowArray[rowArray.count - 1][i] > 0 {
                let block = SKShapeNode(rectOf: CGSize(width: gameArea.width / 7 - (gameArea.width * 0.03), height: gameArea.width / 7 - (gameArea.width * 0.03)))
                block.position = CGPoint(x: gameArea.minX + (block.frame.width / 2) + (block.frame.width * CGFloat(i) + gameArea.width * 0.03), y: self.size.height - 250)
                block.fillColor = SKColor.white
                block.strokeColor = SKColor.clear
                block.zPosition = 11
                block.name = "block"
//                block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: gameArea.width / 7, height: gameArea.width / 7))
//                block.physicsBody!.friction = 0.0
//                block.physicsBody!.allowsRotation = false
//                block.physicsBody!.restitution = 1
//                block.physicsBody!.linearDamping = 0
//                block.physicsBody!.angularDamping = 0
//                block.physicsBody!.isDynamic = false
//                block.physicsBody!.categoryBitMask = PhysicsCategories.Block
//                block.physicsBody!.contactTestBitMask = PhysicsCategories.SceneBoundaryBottom
//                block.physicsBody!.collisionBitMask = PhysicsCategories.SceneBoundaryBottom | PhysicsCategories.SceneBoundaryTop
                self.addChild(block)
                print("create block!")
            }
            
            if rowArray[rowArray.count - 1][i] == -1 {
                // create ball
                print("create ball!")
            }
            
            if rowArray[rowArray.count - 1][i] == -2 {
                // create diamond
                print("create diamond!")
            }
        }
    }
    
    func spawnBlocks() {
        // move blocks down one row visually
        
        let removedRow = blocks.remove(at: 0)
        for j in 0...6 {
            if removedRow[j] > 0 {
                gameOver()
                return
            }
        }
        
        var newRow = [Int]()
        for i in 0...6 {
            newRow.append(Int(arc4random_uniform(2)))
            
            // 20% chance to double the blocks value
            let chanceToDoubleEntry = Int(arc4random_uniform(10))
            newRow[i] = chanceToDoubleEntry > 1 ? newRow[i] * gameLevel : newRow[i] * (gameLevel * 2)
        }
        
        // -2 = diamond. 5% chance
        let chanceToSpawnDiamond = Int(arc4random_uniform(100))
//        print("chance: ", chanceToSpawnDiamond)
        if chanceToSpawnDiamond < 5 {
            newRow[Int(arc4random_uniform(7))] = -2
        }
        
        // -1 = new ball. 100% chance
        newRow[Int(arc4random_uniform(7))] = -1
        
        blocks.append(newRow)
//        print(newRow)
        createBlockNodes(rowArray: blocks)
    }
    
    func gameOver() {
        print("GameOver!")
        // blocks should fall to bottom
        // display screen to pay 25 diamonds to continue
    }
    
    
    
    
//    func runGameOver() {
////        currentGameState = gameState.afterGame
//
//        self.removeAllActions()
//        self.enumerateChildNodes(withName: "Bullet") {
//            bullet, stop in
//            bullet.removeAllActions()
//        }
//
//        self.enumerateChildNodes(withName: "Enemy") {
//            enemy, stop in
//            enemy.removeAllActions()
//        }
//
//        let changeSceneAction = SKAction.run(changeScene)
//        let waitToChangeScene = SKAction.wait(forDuration: 1)
//        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
//        self.run(changeSceneSequence)
//    }
//    func startNewLevel() {
//        levelNumber += 1
//
//        if self.action(forKey: "spawningEnemies") != nil {
//            self.removeAction(forKey: "spawningEnemies")
//        }
//
//        var levelDuration = TimeInterval()
//
//        switch levelNumber {
//        case 1: levelDuration = 1.2
//        case 2: levelDuration = 1
//        case 3: levelDuration = 0.8
//        case 4: levelDuration = 0.5
//        default:
//            levelDuration = 0.5
//            print("Cannot find level info")
//        }
//
//        let spawn = SKAction.run(spawnEnemy)
//        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
//        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
//        let spawnForever = SKAction.repeatForever(spawnSequence)
//        self.run(spawnForever, withKey: "spawningEnemies")
//    }
    
//    func fireBullet() {
//        let bullet = SKSpriteNode(imageNamed: "bullet")
//        bullet.name = "Bullet"
//        bullet.setScale(1)
//        bullet.position = player.position
//        bullet.zPosition = 1
//        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
//        bullet.physicsBody!.affectedByGravity = false
//        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
//        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
//        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
//        self.addChild(bullet)
//
//        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
//        let deleteBullet = SKAction.removeFromParent()
//
//        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
//        bullet.run(bulletSequence)
//    }
    
//    func spawnEnemy() {
//        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
//        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
//        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
//        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
//
//        let enemy = SKSpriteNode(imageNamed: "enemyShip")
//        enemy.name = "Enemy"
//        enemy.setScale(1)
//        enemy.position = startPoint
//        enemy.zPosition = 2
//        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
//        enemy.physicsBody!.affectedByGravity = false
//        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
//        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
//        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
//        self.addChild(enemy)
//
//        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
//        let deleteEnemy = SKAction.removeFromParent()
////        let loseALifeAction = SKAction.run(loseALife)
//        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
//
//        if (currentGameState == gameState.inGame) {
//            enemy.run(enemySequence)
//        }
//
//        let dx = endPoint.x - startPoint.x
//        let dy = endPoint.y - startPoint.y
//        let amountToRotate = atan2(dy, dx)
//        enemy.zRotation = amountToRotate
//    }
    
    var firstBallHitLocation = CGPoint(x: 0, y: 0)
    
    func endTurn() {
        gameLevel += 1
        levelLabel.text = "\(gameLevel)"
        ballsSpawned = 0
        ballsInPlay = 0
        
        if gameLevel > highScore {
            UserDefaults().set(gameLevel, forKey: "highScoreSaved")
            highScore = gameLevel
        }
        
        toggleSelectionOfItem(item: "none")
        currentActiveItem = activeItemState.none
        currentGameState = gameState.readyToShoot
        firstBallHitLocation = CGPoint(x: 0, y: 0)
        
        spawnBlocks()
        saveGame()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var playerNode = SKPhysicsBody()

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            playerNode = contact.bodyB
        } else {
            body1 = contact.bodyB
            playerNode = contact.bodyA
        }

        if body1.categoryBitMask == PhysicsCategories.SceneBoundaryBottom && playerNode.categoryBitMask == PhysicsCategories.Player {
            if playerNode.node != nil {
                let setVelocity = SKAction.run{
                    playerNode.node?.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
                }
                let setPlayerPosition = SKAction.run{
                    playerNode.node?.position = CGPoint(x: (playerNode.node?.position.x)!, y: 185 + (playerNode.node?.frame.height)!)
                }
                self.run(SKAction.sequence([setVelocity, setPlayerPosition]))
                
//                if firstBallHitLocation == CGPoint(x: 0, y: 0) {
//                    firstBallHitLocation = (playerNode.node?.position)!
//                }
                
                ballsInPlay -= 1
                
                if ballsInPlay <= 0 {
                    endTurn()
                }
                
                // This should be a constant speed, not variable. Need to divide new X and old X to get distance?
//                let moveTo = SKAction.move(to: firstBallHitLocation, duration: 0.1)
                
//                if firstBallHitLocation != CGPoint(x: 0, y: 0) {
//                    playerNode.node?.run(moveTo)
//                }
                
                if playerNode.node?.name == "ball" {
                    playerNode.node?.removeFromParent()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            aimLineLength = 0
            touchStart = touch.location(in: self)
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            let defaults = UserDefaults()
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
                case "pauseButton":
                    if currentGameState == gameState.readyToShoot || currentGameState == gameState.gameInProgress {
                        pauseGame()
                    } else if currentGameState == gameState.paused {
                        resumeGame()
                    }
                    
                case "soundButton":
                    if currentGameState == gameState.paused {
                        let node: SKSpriteNode = self.childNode(withName: "soundButton") as! SKSpriteNode
                        if UserDefaults().bool(forKey: "soundEnabledSaved") == true {
                            node.texture = SKTexture(imageNamed: "sound-disabled")
                            defaults.set(false, forKey: "soundEnabledSaved")
                        } else if UserDefaults().bool(forKey: "soundEnabledSaved") == false {
                            node.texture = SKTexture(imageNamed: "sound")
                            defaults.set(true, forKey: "soundEnabledSaved")
                        }
                        
                        if UserDefaults().bool(forKey: "vibrateEnabledSaved") {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        
                        if restartConfirmButtonOpen == true {
                            toggleRestartConfirm()
                        }
                    }
                    
                case "vibrateButton":
                    if currentGameState == gameState.paused {
                        let node: SKSpriteNode = self.childNode(withName: "vibrateButton") as! SKSpriteNode
                        if UserDefaults().bool(forKey: "vibrateEnabledSaved") == true {
                            node.texture = SKTexture(imageNamed: "vibrate-disabled")
                            defaults.set(false, forKey: "vibrateEnabledSaved")
                        } else if UserDefaults().bool(forKey: "vibrateEnabledSaved") == false {
                            node.texture = SKTexture(imageNamed: "vibrate")
                            defaults.set(true, forKey: "vibrateEnabledSaved")
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                        
                        if restartConfirmButtonOpen == true {
                            toggleRestartConfirm()
                        }
                    }
                    
                case "restartButton":
                    if currentGameState == gameState.paused {
                        toggleRestartConfirm()
                    }
                    
                case "confirmButton":
                    UserDefaults().set(false, forKey: "gameSavedData")
                    
                    let sceneToMoveTo = GameScene(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    self.run(fadeChildren)
                    previousScene = scenes.game
                    self.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.2),
                        SKAction.run{self.view!.presentScene(sceneToMoveTo)}
                        ]))
                    
                case "homeButton":
                    if currentGameState == gameState.paused {
                        let sceneToMoveTo = MainMenuScene(size: self.size)
                        sceneToMoveTo.scaleMode = self.scaleMode
                        self.run(fadeChildren)
                        let moveDownBg = SKAction.move(by: CGVector(dx: 0, dy: -self.size.height / 2), duration: 0.2)
                        background.run(moveDownBg)
                        backgroundFlipped.run(moveDownBg)
                        previousScene = scenes.game
                        self.run(SKAction.sequence([
                            SKAction.wait(forDuration: 0.2),
                            SKAction.run{self.view!.presentScene(sceneToMoveTo)}
                            ]))
                    }
                    
                case "bombButton":
                    if bombItemCount > 0 && currentGameState == gameState.readyToShoot {
                        toggleSelectionOfItem(item: "bombButton")
                    }
                    
                    
                case "x2Button":
                    if x2ItemCount > 0 && currentGameState == gameState.readyToShoot {
                        toggleSelectionOfItem(item: "x2Button")
                    }
                    
                case "rowButton":
                    if rowItemCount > 0 && currentGameState == gameState.readyToShoot {
                        toggleSelectionOfItem(item: "rowButton")
                    }
                    
                case "targetButton":
                    if targetItemCount > 0 && currentGameState == gameState.readyToShoot {
                        toggleSelectionOfItem(item: "targetButton")
                    }
                    
                default:
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let lineNode = self.childNode(withName: "line")
        if lineNode != nil {
            lineNode?.removeFromParent()
        }
        
        let deltaX = newPosition.x - player.position.x
        let deltaY = newPosition.y - player.position.y
        let mag = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        if (currentGameState == gameState.readyToShoot || (currentGameState == gameState.paused && previousGameState == gameState.readyToShoot)) && aimLineLength > 150 {
            if currentGameState == gameState.paused {
                resumeGame()
            }
            currentGameState = gameState.gameInProgress
            fireBall(x: deltaX / mag * ballSpeed, y: deltaY / mag * ballSpeed)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let amountDragged = CGPoint(x: pointOfTouch.x - touchStart.x, y: pointOfTouch.y - touchStart.y)
            
            let lineNode = self.childNode(withName: "line")
            if lineNode != nil {
                lineNode?.removeFromParent()
                aimLineLength = 0
            }
            
            if currentGameState == gameState.readyToShoot || (currentGameState == gameState.paused && previousGameState == gameState.readyToShoot) {
                if -amountDragged.y > 50 {
                    newPosition = CGPoint(x: player.position.x - amountDragged.x * 3, y: player.position.y - amountDragged.y * 1.5)
                    
                    let path = UIBezierPath()
                    path.move(to: player.position)
                    path.addLine(to: newPosition)

                    let pattern: [CGFloat] = [20.0, 20.0]
                    let line = SKShapeNode(path: path.cgPath.copy(dashingWithPhase: 2, lengths: pattern))
                    line.strokeColor = SKColor.white
                    line.lineWidth = 5
                    line.name = "line"
                    
//                    let line = SKShapeNode()
//                    let path = UIBezierPath()
//                    path.move(to: player.position)
//                    path.copy
//                    path.addLine(to: newPosition)
//
//                    line.path = path.cgPath
//                    line.strokeColor = SKColor.white
//                    line.lineWidth = 5
//                    line.name = "line"
                    
                    
                    aimLineLength = sqrt((newPosition.x - player.position.x) * (newPosition.x - player.position.x) + (newPosition.y - player.position.y) * (newPosition.y - player.position.y))
                    
                    if aimLineLength > 150 {
                        self.addChild(line)
                    }
                }
            }
        }
    }
}

