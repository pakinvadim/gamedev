//
//  ThingGet.swift
//  GrumpyCat
//
//  Created by admin on 26.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class ThingGet : ThingBase {
    var InvertoryTexture:CCTexture?
    
    override init(scene:IntroScene, imageName: String){
        super.init(scene: scene, imageName: imageName)
    }
    
    func PutToInventary(){
        Scene!.ActualLevel!.Inventory!.AddThing(self)
    }
    
    func ChangeImage(){
        texture = InvertoryTexture!
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
