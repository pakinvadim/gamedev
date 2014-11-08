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
    var GetItPosition:CGPoint?
    
    override init(scene:IntroScene, imageName: String){
        super.init(scene: scene, imageName: imageName)
    }
    
    func PutToInventary(){
        removeFromParent()
        Scene!.ActualLevel!.Inventory!.AddThing(self)
    }
    
    func ChangeImage(){
        texture = InvertoryTexture!
    }
    
    func GetItTask(gameChar:GameChar) -> [TaskBase]{
        if(gameChar is CatChar){
            let anim = DoActionTask(action: (gameChar as CatChar).TakeAction!, canStop:false, name: "Take")
            let put = DoActionTask(action: CCActionCallBlock({self.PutToInventary()}), name: "Put to Inventory")
            return [anim, put]
        }
        println("Error: ThingGet for Cat only")
        return [TaskBase]()
    }
    
    func GetItPosition(gameChar:GameChar) -> CGPoint{
        if(gameChar is CatChar){
            return CcpAdd(Position, GetItPosition!)
        }
        println("Error: ThingGet for Cat only")
        return CGPointZero
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
