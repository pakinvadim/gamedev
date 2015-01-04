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
    var ManStartAction:CCAction?
    var ManEndAction:CCAction?
    var ManJokeAction:CCAction?
    
    var CatStartActionPoint:CGPoint?
    var ManStartActionPoint:CGPoint?
    
    var JokeReadyTexture:CCTexture?
    var JokeReady:Bool = false
    
    override init(scene:IntroScene, imageName: String){
        super.init(scene: scene, imageName: imageName)
        anchorPoint = CGPointMake(0, 1)
    }
    
    func MakeJokeReady(){
        texture = JokeReadyTexture!
        JokeReady = true
    }
    
    func GetTasks(gameChar:GameChar) -> [TaskBase]{
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
                return GetManActionTask()
            }else{
                return GetManJokeTask()
            }
        }
        println("Error: ThingJoke - unknow type")
        return [TaskBase]()
    }
    
    func GetManActionTask() -> [TaskBase]{
        let hideThing = CCActionCallBlock({ self.runAction(CCActionHide() as CCAction); return; })
        let showThing = CCActionCallBlock({ self.runAction(CCActionShow() as CCAction); return; })
        let moveToThing = CCActionMoveTo(duration: 0.001, position: self.Position)
        let moveBack = CCActionMoveTo(duration: 0.001, position: CcpAdd(self.Position, ManStartActionPoint!))
        let standUp = Scene!.ActualLevel!.Man!.StandUpAction!;
        let play = CCActionSequence.actionWithArray([self.ManStartAction!, self.ManEndAction!]) as CCAction
        
        let startSpawn = CCActionSpawn.actionWithArray([hideThing, moveToThing]) as CCAction
        let endSpawn = CCActionSpawn.actionWithArray([moveBack, showThing, standUp]) as CCAction
        
        let action = CCActionSequence.actionWithArray([startSpawn, play, endSpawn]) as CCAction
        
        return [DoActionTask(action: action)]
    }
    
    func GetManJokeTask() -> [TaskBase]{
        return [DoActionTask(action: ManStartAction!), DoActionTask(action: ManJokeAction!)]
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