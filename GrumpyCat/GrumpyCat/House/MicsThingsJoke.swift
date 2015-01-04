//
//  MicsThings.swift
//  GrumpyCat
//
//  Created by admin on 25.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class Zont : ThingJoke {
    init(scene:IntroScene){
        super.init(scene: scene, imageName:"ActionZont (0).png")
        JokeReadyTexture = CCTexture(file: "ActionZont (0).png")
        CatStartActionPoint = CGPointMake(0, 0)
        ManStartActionPoint = CGPointMake(256, 0)
        CatMakeJokeTasks = [DoActionTask(action: RootSprite.GetAction("walkTop", frameCount: 4, delay: 0.1, wight: 186,  hight: 185))]
        
        ManStartAction = RootSprite.GetActionNew("ActionZont", frameRange: [1,2,3,4,5,6], delay: 0.15)
        ManJokeAction = RootSprite.GetActionNew("ActionZont", frameRange: [7,7,7,7,8,9,10,11], delay: 0.15)
        ManEndAction = RootSprite.GetActionNew("JokeZont", frameRange: [1,2,3,4,5,4,3,4,5,6,7,8], delay: 0.15)
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
