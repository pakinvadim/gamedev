//
//  MicsThingsGet.swift
//  GrumpyCat
//
//  Created by admin on 03.01.15.
//  Copyright (c) 2015 COON. All rights reserved.
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