//
//  MoveAndInterDoorTask.swift
//  GrumpyCat
//
//  Created by admin on 19.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class MoveAndInterDoorTask : MoveTaskBase{
    var DoorDirect:Int = 0
    init(doorDirect:Int){
        super.init()
        DoorDirect = doorDirect
    }
    
    override func Populate(scene:IntroScene, char:GameChar){
        let action:CCAction? = GetInterTherDoorAction(scene, char: char)
        Populate(scene, char: char, action: action)
        //Populate(scene, char:char, action:CatBreatheAnimate!)
    }
    
    func GetInterTherDoorAction(scene:IntroScene, char:GameChar) -> CCAction?{
        var actionList:[CCAction] = [CCAction]();
        var level:GameLevel = scene.ActualLevel!;
        
        var moveDown:CCAction?
        var moveX:CCAction?
        var moveUp:CCAction?
        var enterInDoor:CCAction?
        
        //CCSpawn* moveAnimate = nil;

        
        //var callbackAction:CCActionCallFunc?
        //var endPosition:CGPoint
        
        //var nextRoomNum:Int = Way!.Way.first!
        //println("Next room number \(nextRoomNum)")
        
        var room:Room = char.GetActualRoom();
        var door:Door? = room.GetDoor(DoorDirect)
        var nextRoom:Room? = level.GetRoom(DoorDirect)
        var nextDoor:Door? = nextRoom?.GetDoor(room.Numb)
        if(door == nil || nextRoom == nil || nextDoor == nil){
            return nil
        }
        
        var moveXStart:CGPoint = CGPointMake(char.position.x, room.FloorPosition)
        var moveUpStart:CGPoint = CGPointMake(door!.EnterPosition.x, room.FloorPosition)
        if (moveXStart != moveUpStart){//случай когда бот стоит уже возле двери
            /*moveDown = GetCharMoveAnimation(char, direct: MoveDirect.Y, start: char.position, end: moveXStart)
            moveX = GetCharMoveAnimation(char, direct: MoveDirect.X, start: moveXStart, end: moveUpStart)
            moveUp = GetCharMoveAnimation(char, direct: MoveDirect.Y, start: moveUpStart, end: door!.EnterPosition)*/
        }
        //enterInDoor = GetEnterDoorAnimation(char, inDoor:door!, outDoor:nextDoor!)
        
        AddAction(moveDown, array:&actionList)
        AddAction(moveX, array:&actionList)
        AddAction(moveUp, array:&actionList)
        AddAction(enterInDoor, array:&actionList)
        //[self runAction:moveAnimate];
        if(actionList.count != 0){
            return CCActionSequence.actionWithArray(actionList) as CCAction
        }
        return nil
        /*if(Way!.Ways.count == 0){
            RouteRun = false
            println("GO END")
        }*/
    }
    
    func DistanceBetween(sprite1:CCSprite, sprite2:CCSprite) -> Float{
        return sqrtf(Float((sprite1.position.x * sprite2.position.x) + (sprite1.position.y * sprite1.position.y)))
    }
}
