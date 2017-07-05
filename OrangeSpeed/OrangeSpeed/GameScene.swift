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
    
    var blueButton: MSButtonNode!
    var pinkButton: MSButtonNode!
    
    var state: GameState = .title
    
    var colorTower: [coloredBar] = []
    
    var firstBar: coloredBar!
    
    var numberOfPieces = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        blueButton = childNode(withName: "blueButton") as! MSButtonNode
        pinkButton = childNode(withName: "pinkButton") as! MSButtonNode
        firstBar = childNode(withName: "firstBar") as! coloredBar

        // MARK: manually stack the first two pieces
        addTowerPiece(lastColor: .Pink)
        addTowerPiece(lastColor: .Blue)
        addRandomPieces(total: 10)
    }
    
    
    func addTowerPiece (lastColor: LastColor) {
        
        // MARK: adding new pieces to tower.
        let newPiece = firstBar.copy() as! coloredBar
        newPiece.connectBars()
        
        let lastPiece = colorTower.last
        
        let lastPosition = lastPiece?.position ?? firstBar.position
        newPiece.position.x = lastPosition.x
        newPiece.position.y = lastPosition.y + 32
        
        // Increments of Z position
        let lastZPosition = lastPiece?.zPosition ?? firstBar.zPosition
        newPiece.zPosition = lastZPosition
        
        newPiece.lastColor = lastColor
        addChild(newPiece)
        colorTower.append(newPiece)
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
        
        let touch = touches.first!
        
        let location = touch.location(in: self )
        
        if let firstPiece = colorTower.first {
            print(colorTower, "1")
            colorTower.removeFirst()
            print(colorTower, "2")
            addRandomPieces(total: 1)
        }
    }
    func drawTower() {
        var n: CGFloat = 0
        for piece in colorTower {
            let y = (n * 32) + 10
            piece.position.y -= (piece.position.y - y) * 0.5
            n += 1
        }
    }
    override func update(_ currentTime: TimeInterval) {
        drawTower()
    }
}
