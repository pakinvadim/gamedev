//
//  EnterDoorTask.swift
//  GrumpyCat
//
//  Created by admin on 25.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class EnterDoorTask : TaskBase{
    let DoorDirect:Int = 0
    
    init(doorDirect:Int){
        DoorDirect = doorDirect
        super.init()
        CanStop = false
    }
    
    override func Populate(scene:IntroScene, char:GameChar){
        let action:CCAction? = GetInterDoorAction(scene, char: char, doorDirect: DoorDirect)
        Populate(scene, char: char, action: action)
    }
    
    func GetInterDoorAction(scene:IntroScene, char:GameChar, doorDirect:Int) -> CCAction?{
        if(doorDirect == 0){
            return nil
        }
        let room:Room = char.GetActualRoom();
        let inDoor:Door? = room.GetDoor(doorDirect)
        let nextRoom:Room? = scene.ActualLevel!.GetRoom(inDoor!.Direct)
        let outDoor:Door? = nextRoom?.GetDoor(room.Numb)
        if(inDoor == nil || nextRoom == nil || outDoor == nil){
            return nil
        }
        if(char.position.x != inDoor!.EnterPosition.x || char.position.y != inDoor!.EnterPosition.y){
            return nil
        }
        
        var doorsAnimation:CCAction = GetAnimationDoor(char, inDoor: inDoor!, outDoor: outDoor!)
        var charAnimation:CCAction = CCActionMoveTo.actionWithDuration(0, position: outDoor!.EnterPosition) as CCActionMoveTo
        
        return CCActionSequence.actionWithArray([CCActionHide.action(), charAnimation, doorsAnimation, CCActionShow.action()]) as CCActionSequence
    }
    
    func GetAnimationDoor(char:GameChar, inDoor: Door, outDoor: Door) -> CCActionSequence{
        var actionIn:CCAction?
        var actionOut:CCAction?
        var stairsTime:CCActionDelay = CCActionDelay.actionWithDuration(0) as CCActionDelay
        var animationTime:CCActionDelay = CCActionDelay.actionWithDuration(CCTime(Door.DoorAnimationDelay * 7.0)) as CCActionDelay
        
        if(inDoor.Type == DoorType.Left){
            actionIn = char.DoorLeftInAction!
            actionOut = char.DoorRightOutAction!
        }
        else if(inDoor.Type == DoorType.Right){
            actionIn = char.DoorRightInAction!
            actionOut = char.DoorLeftOutAction!
            Flip = true
        }
        else if(inDoor.Type == DoorType.Top){
            actionIn = char.DoorTopInAction!
            actionOut = char.DoorTopOutAction!
            stairsTime = CCActionDelay.actionWithDuration(CCTime(Door.DoorAnimationDelay * 7.0)) as CCActionDelay;// задержка при поднятие по лестнице
            animationTime = CCActionDelay.actionWithDuration(CCTime(Door.DoorAnimationDelay * 14.0)) as CCActionDelay
        }
        let animation = CCActionCallBlock({
            inDoor.runAction(CCActionSequence.actionWithArray([actionIn!, inDoor.SetClosed!]) as CCAction)
            outDoor.runAction(CCActionSequence.actionWithArray([stairsTime, actionOut!, outDoor.SetClosed!]) as CCAction)
            /*inDoor.runAction(CCActionSequence.actionWithArray([inDoor.Opening!, inDoor.Closed!]) as CCAction)
            inDoor.AnimationSprite!.runAction(CCActionSequence.actionWithArray([CCActionShow.action(), actionIn!,CCActionHide.action()]) as CCAction)
            outDoor.runAction(CCActionSequence.actionWithArray([stairsTime, outDoor.Opening!, outDoor.Closed!]) as CCAction)
            outDoor.AnimationSprite!.runAction(CCActionSequence.actionWithArray([stairsTime, CCActionShow.action(), actionOut, CCActionHide.action() as CCAction]) as CCAction)*/
        })
        
        return CCActionSequence.actionWithArray([animation, animationTime]) as CCActionSequence

    }
}