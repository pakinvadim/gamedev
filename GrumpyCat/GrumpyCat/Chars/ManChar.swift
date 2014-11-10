//
//  Man.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class ManChar : GameChar {
    var RepairAction:CCAction?
    
    override init(scene:IntroScene) {
        super.init(scene: scene)
        name = "Man"
        Speed = 210
        anchorPoint = CGPointMake(0.5, 0.15)
        
        let animDelay: CGFloat = 0.12
        WalkRight = RootSprite.GetAnimationNew("ManWalkRight", frameCount: 8, delay: animDelay)
        WalkLeft = RootSprite.GetAnimationNew("ManWalkLeft", frameCount: 8, delay: animDelay)
        WalkUp = RootSprite.GetAnimationNew("ManWalkUp", frameCount: 8, delay: animDelay)
        WalkDown = RootSprite.GetAnimationNew("ManWalkDown", frameCount: 8, delay: animDelay)
        
        DoorLeftInAction = RootSprite.GetActionNew("ManDoorLeftOut", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorLeftOutAction = RootSprite.GetActionNew("ManDoorLeftIn", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorRightInAction = RootSprite.GetActionNew("ManDoorRightOut", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorRightOutAction = RootSprite.GetActionNew("ManDoorRightIn", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorTopInAction = RootSprite.GetActionNew("ManDoorUpOut", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorTopOutAction = RootSprite.GetActionNew("ManDoorUpIn", frameCount:10, delay:Door.DoorAnimationDelay)
        
        //BreatheAction = RootSprite.GetActionNew("ManWalkDown", frameCount: 2, delay: 1)
        RepairAction = RootSprite.GetActionNew("ManRepair", frameCount: 7, delay: animDelay)
        //PermanentTasks.append(DoActionTask(action: self.BreatheAction!, name: "Breathe"))
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}