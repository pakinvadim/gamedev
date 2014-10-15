//
//  Cat.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class CatChar : GameChar {
    let AnimDelay: CGFloat = 0.1
    
    override init() {
        super.init()//imageNamed: "Icon-72.png")
        Type = BotType.Cat
        
        WalkRight = GetAnimation("walkLeft", frameCount: 5, delay: AnimDelay, wight: 186,  hight: 185)
        WalkLeft = GetAnimation("walkLeft", frameCount: 5, delay: AnimDelay, wight: 186,  hight: 185)
        WalkUp = GetAnimation("walkTop", frameCount: 4, delay: AnimDelay, wight: 186,  hight: 185)
        WalkDown = GetAnimation("walkBotton", frameCount: 4, delay: AnimDelay, wight: 186,  hight: 185)
        Stand = GetAnimation("standBotton", frameCount: 2, delay: 1, wight: 186,  hight: 185)
        
        StandAnimate = CCActionRepeatForever.actionWithAction(CCActionAnimate.actionWithAnimation(Stand) as CCActionInterval) as CCActionRepeatForever
        
        DoorLeftIn = GetAnimation("CatAnimEnterDoorLeftIn", frameCount:6, delay:DoorAnimationDelay, wight: 186,hight: 172)
        DoorLeftOut = GetAnimation("CatAnimEnterDoorLeftOut", frameCount:6, delay:DoorAnimationDelay, wight: 186, hight: 172)
        DoorRightIn = GetAnimation("CatAnimEnterDoorRightIn", frameCount:6, delay:DoorAnimationDelay, wight: 186, hight: 172)
        DoorRightOut = GetAnimation("CatAnimEnterDoorRightOut", frameCount:6, delay:DoorAnimationDelay, wight:186, hight:141)
        DoorTopIn = GetAnimation("CatAnimEnterDoorTopIn", frameCount:6, delay:DoorAnimationDelay, wight:186, hight:258)
        DoorTopOut = GetAnimation("CatAnimEnterDoorTopOut", frameCount:6, delay:DoorAnimationDelay, wight:186, hight:255)
        
        //var action = CCActionAnimate.actionWithAnimation(self.WalkLeft) as CCActionAnimate
        //var repeatAction = CCActionRepeat.actionWithAction(action, times: 1000) as CCActionRepeat
        //self.scale = 1
        //self.position = CGPoint(x: 90, y: 120)
        //self.runAction(repeatAction)
        
        Stand()
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        super.touchBegan(touch, withEvent: event)
    }
}