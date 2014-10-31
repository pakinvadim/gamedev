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
        
        let CatActionAnimation = RootSprite.GetAnimation("walkTop", frameCount: 4, delay: 0.1, wight: 186,  hight: 185)
        let CatAction = CCActionAnimate.actionWithAnimation(CatActionAnimation) as CCAction
        CatActionTasks = [DoActionTask(action: CatAction, canStop:false), DoActionTask(action: CCActionCallBlock({self.PutToInventary()}))]
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}

class Televizor : ThingBase {
    init(scene:IntroScene){
        super.init(scene: scene, imageName:"tv.jpeg")
        
        var CatActionAnimation = RootSprite.GetAnimation("walkTop", frameCount: 4, delay: 0.1, wight: 186,  hight: 185)
        CatAction = CCActionAnimate.actionWithAnimation(CatActionAnimation) as? CCAction
        
        var ManActionAnimation = RootSprite.GetAnimation("walkTop", frameCount: 4, delay: 0.1, wight: 186,  hight: 185)
        ManAction = CCActionAnimate.actionWithAnimation(CatActionAnimation) as? CCAction
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
