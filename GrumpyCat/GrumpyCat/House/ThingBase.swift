//
//  ThingBase.swift
//  GrumpyCat
//
//  Created by admin on 25.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class ThingBase : RoomObject {
    var CatActionTasks:[TaskBase] = [TaskBase]()
    var ManActionTasks:[TaskBase] = [TaskBase]()
    
    var CatStartActionPoint:CGPoint = CGPoint.zeroPoint
    var ManStartActionPoint:CGPoint = CGPoint.zeroPoint
    
    init(scene:IntroScene, imageName: String){
        super.init(scene: scene, imageNamed: imageName)
    }
    
    func GetActionTasks(gameChar:GameChar) -> [TaskBase]{
        if(gameChar is CatChar){
            return CatActionTasks
        }
        if(gameChar is ManChar){
            return ManActionTasks
        }
        return [TaskBase]()
    }
    
    func GetActionPosition(gameChar:GameChar) -> CGPoint{
        if(gameChar is CatChar){
            return CcpAdd(Position, CatStartActionPoint)
        }
        if(gameChar is ManChar){
            return CcpAdd(Position, ManStartActionPoint)
        }
        return CGPoint.zeroPoint
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
