//
//  RoomObject.swift
//  GrumpyCat
//
//  Created by admin on 26.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class RoomObject : RootSprite{
    var CurrentRoom: Room?
    var Width:CGFloat = 0
    var Height:CGFloat = 0
    var Position:CGPoint{ get{ return CcpAdd(CurrentRoom!.position, position) } }
    
    override init(scene:IntroScene) {
        super.init(scene: scene)
        Width = contentSize.width
        Height = contentSize.height
        anchorPoint = ccp(0,0)
    }
    
    override init(scene: IntroScene, imageNamed imageName: String!) {
        super.init(scene: scene, imageNamed: imageName)
        Width = contentSize.width
        Height = contentSize.height
        anchorPoint = CGPointMake(0,0)
    }
    
    func Contain(location:CGPoint) -> Bool{
        var rectRoom:CGRect = CGRectMake(position.x, position.y, Width, Height);
        return CGRectContainsPoint(rectRoom, location)
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}