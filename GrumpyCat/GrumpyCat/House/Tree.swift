//
//  Tree.swift
//  GrumpyCat
//
//  Created by admin on 17.12.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class Tree : RootSprite {
    
    override init(scene:IntroScene){
        super.init(scene: scene)
        self.anchorPoint = CGPointZero
        let offset = CGPointMake(300, 350)
        let offset2 = CGPointMake(200, 500)
        let positionsByPictDic:[(pictName:String, positions:[CGPoint])] = [
            ("T1.png", [
                    CcpAdd(offset, CGPointMake(1150, 700)),
                    CcpAdd(offset, CGPointMake(1000, 750)),
                    CcpAdd(offset, CGPointMake(900, 680))
                ]),
            ("T2.png", [
                    CcpAdd(offset, CGPointMake(1000, 750)),
                    CcpAdd(offset, CGPointMake(900, 800)),
                    CcpAdd(offset, CGPointMake(800, 700))
                ]),
            ("T3.png", [
                    CcpAdd(offset2, CGPointMake(1150, 1000)),
                    CcpAdd(offset2, CGPointMake(1300, 1150)),
                    CcpAdd(offset2, CGPointMake(1450, 1300)),
                    CcpAdd(offset2, CGPointMake(1600, 1450)),
                
                    CcpAdd(offset2, CGPointMake(1150, 850)),
                    CcpAdd(offset2, CGPointMake(1300, 1000)),
                    CcpAdd(offset2, CGPointMake(1450, 1150)),
                    CcpAdd(offset2, CGPointMake(1600, 1300)),
                
                    CcpAdd(offset2, CGPointMake(1150, 700)),
                    CcpAdd(offset2, CGPointMake(1300, 850)),
                    CcpAdd(offset2, CGPointMake(1450, 1000)),
                    CcpAdd(offset2, CGPointMake(1600, 1150))
                ])
        ]
        
        let treeUp = CCSprite(imageNamed: "TUP.png");
        treeUp.anchorPoint = CGPointZero
        treeUp.position = CGPointMake(116, 512)
        
        for info in positionsByPictDic {
            for pos in info.positions {
                let pictCopy:CCSprite = CCSprite(imageNamed: info.pictName)
                pictCopy.position = pos
                treeUp.addChild(pictCopy)
            }
        }
        addChild(treeUp)
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}