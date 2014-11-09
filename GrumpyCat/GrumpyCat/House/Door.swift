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

    var AnimationSprite: CCSprite?
    let EnterIndentDoor: CGFloat = 17
    
    class var DoorAnimationDelay:CGFloat { get {return 0.1 } }
    let Direct: Int = 0
    let Type: DoorType = DoorType.Top
    
    var EnterPosition: CGPoint{
        get{
            var room = CurrentRoom!
            if(Type == DoorType.Left){
                return CGPointMake(Position.x + Width/2.0 + EnterIndentDoor, room.FloorPosition)
            }
            if(Type == DoorType.Right){
                return CGPointMake(Position.x + Width/2 - EnterIndentDoor, room.FloorPosition)
            }
            if(Type == DoorType.Top){
                return CGPointMake(Position.x + Width/2, room.FloorPosition + 50);
            }
            return ccp(0,0);
        }
    }
        
    init(scene:IntroScene, type: DoorType, direct: Int) {
        var name: String = ""
        if ( type == DoorType.Left ){ name = "DoorLeft.png"; }
        else if (type == DoorType.Right){ name = "DoorRight.png"; }
        else if ( type == DoorType.Top ){ name = "DoorTop.png"; }
        
        super.init(scene: scene, imageNamed: name)
        Type = type
        Direct = direct
        AnimationSprite = CCSprite()
        AnimationSprite!.position = ccp(0, 0)
        AnimationSprite!.anchorPoint = ccp(0, 0)
        
        ClosedTexture = CCTexture(file: name)
        SetClosed = CCActionCallBlock({self.texture = self.ClosedTexture})
        //CCActionAnimate.actionWithAnimation(RootSprite.GetAnimation(name, frameCount: 1, delay: Door.DoorAnimationDelay, wight: 186, hight: 500)) as CCActionAnimate
        /*Opening = CCActionAnimate.actionWithAnimation(RootSprite.GetAnimation(name, frameRange: [1, 2, 3, 3, 2, 1], delay: Door.DoorAnimationDelay, wight: 186, hight: 500)) as CCActionAnimate*/
        
        addChild(AnimationSprite!)
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
