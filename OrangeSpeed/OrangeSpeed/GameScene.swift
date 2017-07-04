//
//  GameScene.swift
//  OrangeSpeed
//
//  Created by timofey makhlay on 7/3/17.
//  Copyright © 2017 timofey makhlay. All rights reserved.
//


import GameplayKit

enum CurrentColor {
    case pink, blue
}

enum GameState {
    case title, ready, playing, gameOver
}


enum LastColor {
    case Pink , Blue
}

class GameScene: SKScene {
    
    var blue: SKSpriteNode!
    var pink: SKSpriteNode!
    
    var blueButton: MSButtonNode!
    var pinkButton: MSButtonNode!
    
    var state: GameState = .title
    
    var colorTower: [SKSpriteNode] = []
    
    var firstBar: SKSpriteNode!
    
    var currentColor: CurrentColor = .blue {
        
        didSet {
            switch currentColor {
            case .pink:
                pink.isHidden = false
                
            case .blue:
                blue.isHidden = false
            }
        }
    }
    
    var lastColor: LastColor = .Pink {
        didSet{
            switch lastColor {
            case .Pink:
                break
            case .Blue:
                break
            }
        }
    }
    
    var numberOfPieces = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        blueButton = childNode(withName: "blueButton") as! MSButtonNode
        pinkButton = childNode(withName: "pinkButton") as! MSButtonNode
        firstBar = childNode(withName: "firstBar") as! SKSpriteNode
        blue = childNode(withName: "blue") as! SKSpriteNode
        pink = childNode(withName: "pink") as! SKSpriteNode
        
        // MARK: manually stack the first two pieces
        addTowerPiece(currentColor: .pink)
        addTowerPiece(currentColor: .blue)
        addRandomPieces(total: 2)
    }
    
    
    func addTowerPiece (currentColor: CurrentColor) {
        
        blue.position = firstBar.position
        pink.position = firstBar.position
        
        var newPiece = firstBar.copy() as! SKSpriteNode
        
        if currentColor == .blue {
            newPiece = blue.copy() as! SKSpriteNode
            let lastPiece = colorTower.last
            
            let lastPosition = lastPiece?.position ?? blue.position
            newPiece.position.x = lastPosition.x
            newPiece.position.y = lastPosition.y + 32
            
            // Increments of Z position
            let lastZPosition = lastPiece?.zPosition ?? blue.zPosition
            newPiece.zPosition = lastZPosition
            
            addChild(newPiece)
            colorTower.append(newPiece)
            lastColor = .Blue
            
            numberOfPieces += 1
            print(numberOfPieces)
            
        } else if currentColor == .pink {
            newPiece = pink.copy() as! SKSpriteNode
            let lastPiece = colorTower.last
            
            let lastPosition = lastPiece?.position ?? pink.position
            newPiece.position.x = lastPosition.x
            newPiece.position.y = lastPosition.y + 32
            
            // Increments of Z position
            let lastZPosition = lastPiece?.zPosition ?? pink.zPosition
            newPiece.zPosition = lastZPosition
            
            addChild(newPiece)
            colorTower.append(newPiece)
            lastColor = .Pink
            
            numberOfPieces += 1
            print(numberOfPieces)
        }
        
    }
    
    func addRandomPieces ( total: Int)
    {
        // MARK: add random pieces
        for _ in 1...total {
            
            let rand = arc4random_uniform(100)
            
            if rand < 50 {
                addTowerPiece(currentColor: .pink)
            } else if rand < 100 {
                addTowerPiece(currentColor: .blue)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        blueButton.selectedHandler = {
            if self.lastColor ==  .Blue{
                self.colorTower.last?.removeFromParent()
                print("it works so far")
            }
            return
        }
        
        pinkButton.selectedHandler = {
            if self.lastColor == .Pink{
                self.colorTower.last?.removeFromParent()
                print("this also works")
            }
            return
        }
    }
}
