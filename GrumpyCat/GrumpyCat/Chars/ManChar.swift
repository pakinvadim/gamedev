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
        WalkRight = RootSprite.GetAnimationNew("MAngry", frameCount: 19, delay: animDelay)
        WalkLeft = RootSprite.GetAnimationNew("MAngry", frameCount: 19, delay: animDelay)
        WalkUp = RootSprite.GetAnimationNew("MAngry", frameCount: 19, delay: animDelay)
        WalkDown = RootSprite.GetAnimationNew("MAngry", frameCount: 19, delay: animDelay)
        
        DoorLeftInAction = RootSprite.GetActionNew("MDLI", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorLeftOutAction = RootSprite.GetActionNew("MDLO", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorRightInAction = RootSprite.GetActionNew("MDRI", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorRightOutAction = RootSprite.GetActionNew("MDRO", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorTopInAction = RootSprite.GetActionNew("MDUI", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorTopOutAction = RootSprite.GetActionNew("MDUO", frameCount:10, delay:Door.DoorAnimationDelay)
        
        //BreatheAction = RootSprite.GetActionNew("ManWalkDown", frameCount: 2, delay: 1)
        RepairAction = RootSprite.GetActionNew("MRepair", frameCount: 7, delay: animDelay)
        //PermanentTasks.append(DoActionTask(action: self.BreatheAction!, name: "Breathe"))
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}