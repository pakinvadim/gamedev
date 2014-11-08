//
//  ThingAction.swift
//  GrumpyCat
//
//  Created by admin on 31.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class ThingJoke : ThingBase {
    var CatMakeJokeTasks:[TaskBase]?
    var ManUsingTasks:[TaskBase]?
    var ManJokeTasks:[TaskBase]?
    
    var CatStartActionPoint:CGPoint?
    var ManStartActionPoint:CGPoint?
    
    var JokeReadyTexture:CCTexture?
    var JokeReady:Bool = false
    
    override init(scene:IntroScene, imageName: String){
        super.init(scene: scene, imageName: imageName)
    }
    
    func MakeJokeReady(){
        texture = JokeReadyTexture!
        JokeReady = true
    }
    
    func GetJokeTasks(gameChar:GameChar) -> [TaskBase]{
        if(gameChar is CatChar){
            if(!JokeReady){
                let anim = DoActionTask(action: (gameChar as CatChar).MakeJokeAction!, canStop: false, name: "MakeJoke")
                let changeImage = DoActionTask(action: CCActionCallFunc(MakeJokeReady()), canStop: false, name: "Change Image")
                return [anim, changeImage]
            }else{
                return [TaskBase]()
            }
        }
        if(gameChar is ManChar){
            if(!JokeReady){
                return ManUsingTasks!
            }else{
                return ManJokeTasks!
            }
        }
        println("Error: ThingJoke - unknow type")
        return [TaskBase]()
    }
    
    func GetJokePosition(gameChar:GameChar) -> CGPoint{
        if(gameChar is CatChar){
            return CcpAdd(Position, CatStartActionPoint!)
        }
        if(gameChar is ManChar){
            return CcpAdd(Position, ManStartActionPoint!)
        }
        println("Error: ThingJoke - unknow type")
        return CGPoint.zeroPoint
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}