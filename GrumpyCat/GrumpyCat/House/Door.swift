//
//  Door.swift
//  GrumpyCat
//
//  Created by admin on 10.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class Door: RoomObject {
    var SetClosed: CCAction?
    var ClosedTexture: CCTexture?
    //var Opening: CCActionAnimate?

    //var AnimationSprite: CCSprite?
    let EnterIndentDoor: CGFloat = 150
    
    class var DoorAnimationDelay:CGFloat { get {return 0.15 } }
    let Direct: Int = 0
    let Type: DoorType = DoorType.Top
    
    var EnterPosition: CGPoint{
        get{
            var room = CurrentRoom!
            if(Type == DoorType.Left){
                return CGPointMake(Position.x + EnterIndentDoor, room.FloorPosition)
            }
            if(Type == DoorType.Right){
                return CGPointMake(Position.x - EnterIndentDoor, room.FloorPosition)
            }
            if(Type == DoorType.Top){
                return CGPointMake(Position.x, room.FloorPosition + 50);
            }
            return ccp(0,0);
        }
    }
        
    init(scene:IntroScene, type: DoorType, direct: Int) {
        var name: String = ""
        if ( type == DoorType.Left ){ name = "MDLO (1)"; }
        else if (type == DoorType.Right){ name = "MDRO (1)"; }
        else if ( type == DoorType.Top ){ name = "MDUO (1)"; }
        
        super.init(scene: scene, imageNamed: "\(name).png")
        anchorPoint = CGPointMake(0, 1)
        Type = type
        Direct = direct
        //AnimationSprite = CCSprite()
        //AnimationSprite!.position = ccp(0, 0)
        //AnimationSprite!.anchorPoint = ccp(0, 0)
        
        SetClosed = RootSprite.GetActionNew(name, frameCount: 1, delay: 0.01)
        //addChild(AnimationSprite!)
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
