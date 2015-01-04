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
        
        /*var doorsAnimation:CCAction = GetAnimationDoor(char, inDoor: inDoor!, outDoor: outDoor!)
        var charAnimation:CCAction = CCActionMoveTo.actionWithDuration(0, position: outDoor!.EnterPosition) as CCActionMoveTo
        
        return CCActionSequence.actionWithArray([CCActionHide.action(), charAnimation, doorsAnimation, CCActionShow.action()]) as CCActionSequence*/
        
        let enterDoorActions = GetAnimationDoor(char, inDoor: inDoor!, outDoor: outDoor!)
        return CCActionSpawn.actionWithArray([enterDoorActions.In, enterDoorActions.Out]) as CCAction
    }
    
    func GetAnimationDoor(char:GameChar, inDoor: Door, outDoor: Door) -> (In:CCAction, Out:CCAction){//-> CCActionSequence{
        var actionIn:CCAction?
        var actionOut:CCAction?
        var actionStand:CCAction?
        var stairsTime:CCActionDelay = CCActionDelay.actionWithDuration(0) as CCActionDelay
        
        if(inDoor.Type == DoorType.Left){
            actionIn = char.DoorLeftInAction!
            actionOut = char.DoorRightOutAction!
            actionStand = char.StandLeftAction!
        }
        else if(inDoor.Type == DoorType.Right){
            actionIn = char.DoorRightInAction!
            actionOut = char.DoorLeftOutAction!
            actionStand = char.StandRightAction!
        }
        else if(inDoor.Type == DoorType.Top){
            actionIn = char.DoorTopInAction!
            actionOut = char.DoorTopOutAction!
            actionStand = char.Stand5DownAction!
            stairsTime = CCActionDelay.actionWithDuration(CCTime(Door.DoorAnimationDelay * 7.0)) as CCActionDelay;// задержка при поднятие по лестнице
        }
        /*let animation = CCActionCallBlock({
            inDoor.runAction(CCActionSequence.actionWithArray([actionIn!, inDoor.SetClosed!]) as CCAction)
            outDoor.runAction(CCActionSequence.actionWithArray([stairsTime, actionOut!, outDoor.SetClosed!]) as CCAction)
        })
        
        return CCActionSequence.actionWithArray([animation, animationTime]) as CCActionSequence*/
        
        let inDoorAction = CCActionSequence.actionWithArray([actionIn!, inDoor.SetClosed!]) as CCAction
        let inAction = CCActionCallBlock({ inDoor.runAction(CCActionSequence.actionWithArray([inDoorAction, inDoor.SetClosed!]) as CCAction); return; }) as CCAction
        
        let setPose = CCActionMoveTo.actionWithDuration(0.001, position: outDoor.Position) as CCActionMoveTo
        let setPoseAndHide = CCActionSpawn.actionWithArray([CCActionHide.action(), setPose])  as CCAction
        
        let hideOutDoor = CCActionCallBlock({ outDoor.runAction(CCActionHide.action() as CCAction); return; }) as CCAction
        let showOutDoor = CCActionCallBlock({ outDoor.runAction(CCActionShow.action() as CCAction); return; }) as CCAction
        
        let showAndActionOut = CCActionSpawn.actionWithArray([hideOutDoor, CCActionShow.action(), actionOut!]) as CCAction
        
        let moveToEnterPosition = CCActionMoveTo.actionWithDuration(0.000, position: outDoor.EnterPosition) as CCActionMoveTo
        let backPose = CCActionSpawn.actionWithArray([showOutDoor, actionStand!, moveToEnterPosition]) as CCAction
        
        let outAction = CCActionSequence.actionWithArray([setPoseAndHide, stairsTime, showAndActionOut, backPose]) as CCAction
        return (inAction, outAction)
    }
}