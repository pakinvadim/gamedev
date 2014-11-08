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
    var TakeAction:CCAction?
    var MakeJokeAction:CCAction?
    
    override init(scene:IntroScene) {
        super.init(scene: scene)//imageNamed: "Icon-72.png")
        name = "Cat"
        anchorPoint = CGPointMake(0.5, 0.15)
        
        WalkRight = RootSprite.GetAnimation("walkLeft", frameCount: 5, delay: AnimDelay, wight: 186,  hight: 185)
        WalkLeft = RootSprite.GetAnimation("walkLeft", frameCount: 5, delay: AnimDelay, wight: 186,  hight: 185)
        WalkUp = RootSprite.GetAnimation("walkTop", frameCount: 4, delay: AnimDelay, wight: 186,  hight: 185)
        WalkDown = RootSprite.GetAnimation("walkBotton", frameCount: 4, delay: AnimDelay, wight: 186,  hight: 185)
        
        BreatheAction = RootSprite.GetAction("standBotton", frameCount: 2, delay: 10, wight: 186,  hight: 185)
        TakeAction = RootSprite.GetAction("walkBotton", frameCount: 4, delay: 0.1, wight: 186,  hight: 185)
        MakeJokeAction = RootSprite.GetAction("walkBotton", frameCount: 4, delay: 0.1, wight: 186,  hight: 185)
        
        DoorLeftInAction = RootSprite.GetAction("CatAnimEnterDoorLeftIn", frameCount:6, delay:Door.DoorAnimationDelay, wight: 186,hight: 172)
        DoorLeftOutAction = RootSprite.GetAction("CatAnimEnterDoorLeftOut", frameCount:6, delay:Door.DoorAnimationDelay, wight: 186, hight: 172)
        DoorRightInAction = RootSprite.GetAction("CatAnimEnterDoorRightIn", frameCount:6, delay:Door.DoorAnimationDelay, wight: 186, hight: 172)
        DoorRightOutAction = RootSprite.GetAction("CatAnimEnterDoorRightOut", frameCount:6, delay:Door.DoorAnimationDelay, wight:186, hight:141)
        DoorTopInAction = RootSprite.GetAction("CatAnimEnterDoorTopIn", frameCount:6, delay:Door.DoorAnimationDelay, wight:186, hight:258)
        DoorTopOutAction = RootSprite.GetAction("CatAnimEnterDoorTopOut", frameCount:6, delay:Door.DoorAnimationDelay, wight:186, hight:255)
        
        //var action = CCActionAnimate.actionWithAnimation(self.WalkLeft) as CCActionAnimate
        //var repeatAction = CCActionRepeat.actionWithAction(action, times: 1000) as CCActionRepeat
        //self.scale = 1
        //self.position = CGPoint(x: 90, y: 120)
        //self.runAction(repeatAction)
        
        //DoStand()
        PermanentTasks.append(DoActionTask(action: self.BreatheAction!, name: "Breathe"))
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}