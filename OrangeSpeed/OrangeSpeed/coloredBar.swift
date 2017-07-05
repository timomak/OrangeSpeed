//
//  SushiPiece.swift
//  SushiNeko
//
//  Created by timofey makhlay on 6/26/17.
//  Copyright © 2017 timofey makhlay. All rights reserved.
//

import SpriteKit

class coloredBar: SKSpriteNode {
    
    var blue: SKSpriteNode!
    var pink: SKSpriteNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func connectBars() {
        blue = childNode(withName: "blue") as! SKSpriteNode
        pink = childNode(withName: "pink") as! SKSpriteNode
        
        
        lastColor = .Blue
    }
    
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
}
