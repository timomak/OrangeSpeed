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
    
    var lastColor: LastColor = .Pink {
        didSet{
            switch lastColor {
            case .Pink:
                blue.isHidden = true
                pink.isHidden = false
            case .Blue:
                pink.isHidden = true
                blue.isHidden = false
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
        addTowerPiece(lastColor: .Pink)
        addTowerPiece(lastColor: .Blue)
        addRandomPieces(total: 1)
    }
    
    
    func addTowerPiece (lastColor: LastColor) {
        
        blue.position = firstBar.position
        pink.position = firstBar.position
        
        var newPiece = firstBar.copy() as! SKSpriteNode
        
        if lastColor == .Blue {
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
            
            numberOfPieces += 1
            print(numberOfPieces)
            
        } else if lastColor == .Pink {
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
                addTowerPiece(lastColor: .Pink)
            } else if rand < 100 {
                addTowerPiece(lastColor: .Blue)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        blueButton.selectedHandler = {
            if self.lastColor ==  .Blue{
                self.colorTower.first?.removeFromParent()
                print("it works so far")
            }
            return
        }
        
        pinkButton.selectedHandler = {
            if self.lastColor == .Pink{
                self.colorTower.first?.removeFromParent()
                print("this also works")
            }
            return
        }
    }
}
