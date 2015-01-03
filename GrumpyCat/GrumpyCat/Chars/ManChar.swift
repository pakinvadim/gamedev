//
//  Man.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class ManChar : GameChar {
    let animDelayCon: CGFloat = 25.2
    var RepairAction:CCAction?
    
    override init(scene:IntroScene) {
        super.init(scene: scene)
        name = "Man"
        Speed = 200
        let animDelay:CGFloat = animDelayCon / Speed
        WalkRight = RootSprite.GetAnimationNew("MWR", frameCount: 8, delay: animDelay)
        WalkLeft = RootSprite.GetAnimationNew("MWL", frameCount: 8, delay: animDelay)
        WalkUp = RootSprite.GetAnimationNew("MWU", frameCount: 8, delay: animDelay)
        WalkDown = RootSprite.GetAnimationNew("MWD", frameCount: 8, delay: animDelay)
        
        Step = 22.5;
        LeftStep = RootSprite.GetFrameActions("MWL", frameCount: 8, step: CGPointMake(0-Step, 0), delay: 0.1, gameChar: self)
        
        StandRightAction = RootSprite.GetActionNew("MWR (1)", frameCount: 1, delay: 0.001)
        StandLeftAction = RootSprite.GetActionNew("MWL (1)", frameCount: 1, delay: 0.001)
        StandUpAction = RootSprite.GetActionNew("MWU (1)", frameCount: 1, delay: 0.001)
        Stand5DownAction = RootSprite.GetActionNew("MWD (1)", frameCount: 1, delay: 0.001)
        
        DoorLeftInAction = RootSprite.GetActionNew("MDLI", frameCount:11, delay:Door.DoorAnimationDelay)
        DoorLeftOutAction = RootSprite.GetActionNew("MDLO", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorRightInAction = RootSprite.GetActionNew("MDRI", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorRightOutAction = RootSprite.GetActionNew("MDRO", frameCount:11, delay:Door.DoorAnimationDelay)
        DoorTopInAction = RootSprite.GetActionNew("MDUI", frameCount:10, delay:Door.DoorAnimationDelay)
        DoorTopOutAction = RootSprite.GetActionNew("MDUO", frameCount:10, delay:Door.DoorAnimationDelay)
        //runAction(RootSprite.GetActionNew("MWD", frameCount: 8, delay: animDelay))
        //BreatheAction = RootSprite.GetActionNew("ManWalkDown", frameCount: 2, delay: 1)
        RepairAction = RootSprite.GetActionNew("MRepair", frameCount: 7, delay: 0.1)
        //PermanentTasks.append(DoActionTask(action: self.BreatheAction!, name: "Breathe"))
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}