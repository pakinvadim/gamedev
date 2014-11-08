//
//  MicsThings.swift
//  GrumpyCat
//
//  Created by admin on 25.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class Otvertka : ThingGet {
    
    init(scene:IntroScene){
        super.init(scene: scene, imageName: "otv.png")
        InvertoryTexture = CCTexture(file: "otv-2.jpg")//CCTextureCache.sharedTextureCache().addImage("")
        GetItPosition = CGPointMake(0, 0)
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}

class Televizor : ThingJoke {
    init(scene:IntroScene){
        super.init(scene: scene, imageName:"tv.jpeg")
        JokeReadyTexture = CCTexture(file: "tv-2.jpg")
        CatStartActionPoint = CGPointMake(0, 0)
        ManStartActionPoint = CGPointMake(0, 0)
        CatMakeJokeTasks = [DoActionTask(action: RootSprite.GetAction("walkTop", frameCount: 4, delay: 0.1, wight: 186,  hight: 185))]
        ManUsingTasks = [DoActionTask(action: scene.ActualLevel!.Man!.RepairAction!, name: "Repair")]
        //ManActionTasks = RootSprite.GetAction("walkTop", frameCount: 4, delay: 0.1, wight: 186,  hight: 185)
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
