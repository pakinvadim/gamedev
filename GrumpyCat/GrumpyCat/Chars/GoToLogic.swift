//
//  GoToPointLogic.swift
//  GrumpyCat
//
//  Created by admin on 19.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class GoToLogic {
    
    class func GoToRoomObject(scene:IntroScene, char:GameChar, object:RoomObject) -> [TaskBase]{
        return GoToLocation(scene, char: char, touch: object.CenterPosition)
    }
    
    class func GoToLocation(scene:IntroScene, char:GameChar, touch:CGPoint) -> [TaskBase]{
        var tasks:[TaskBase] = [TaskBase]()
        
        let touchObj:RoomObject? = GetTouchObject(scene, touch:touch)
        let endResult = GetEndRoomAndPoint(scene, char:char, touch:touch, roomObj:touchObj)
        
        if(endResult.Room == nil || endResult.Point == nil){
            return tasks
        }
        let startRoom:Room = char.GetActualRoom()
        tasks += GetWayActions(scene, startRoom: startRoom, endRoom: endResult.Room!, endPoint: endResult.Point!)
        if(touchObj is ThingBase){
            if(touchObj is ThingGet){
                tasks += (touchObj as ThingGet).GetItTask(char)
            } else if (touchObj is ThingJoke){
                tasks += (touchObj as ThingJoke).GetJokeTasks(char)
            }
        }
        return tasks.reverse()
    }
    
    class func GetWayActions(scene:IntroScene, startRoom:Room, endRoom:Room, endPoint:CGPoint) -> [TaskBase]{
        var tasks:[TaskBase] = [TaskBase]()
        println("start room number \(startRoom.Numb)")
        println("end room number \(endRoom.Numb)")
        
        let wayInfo = WayInfo.GetWay(scene, startRoom: startRoom, endRoom: endRoom, endPoint: endPoint)
        for var i:Int = 1; i < wayInfo.Way.count; i++ {
            let door:Door = scene.ActualLevel!.GetDoor(wayInfo.Way[i-1], outRoomNum: wayInfo.Way[i])!
            tasks.append(MoveInRoomTask(point: door.EnterPosition, moveUp:true))
            tasks.append(EnterDoorTask(doorDirect: wayInfo.Way[i]))
        }
        tasks.append(MoveInRoomTask(point: wayInfo.EndPoint!, moveUp:true))
        
        return tasks
    }
    
    class func GetTouchObject(scene:IntroScene, touch:CGPoint) -> RoomObject? {
        let touchThing:ThingBase? = scene.ActualLevel!.GetThingInSceenPoint(touch)
        if(touchThing != nil){
            return touchThing!
        }
        let touchDoor:Door? = scene.ActualLevel!.GetDoorInSceenPoint(touch)
        if(touchDoor != nil){
            return touchDoor
        }
        return nil
    }
    
    class func GetEndRoomAndPoint(scene:IntroScene, char:GameChar, touch:CGPoint, roomObj:RoomObject?) -> (Room:Room?, Point:CGPoint?){
        if(roomObj is Door){
            let door = roomObj as Door
            let endRoom:Room = scene.ActualLevel!.GetRoom(door.Direct)!
            let endDoor:Door = endRoom.GetDoor(door.CurrentRoom!.Numb)!
            let endPoint:CGPoint = endDoor.EnterPosition
            return (endRoom, endPoint)
        }
        if(roomObj is ThingBase){
            let endRoom:Room = roomObj!.CurrentRoom!
            if(roomObj is ThingGet){
                let thing = roomObj as ThingGet
                let endPoint:CGPoint = thing.GetItPosition(char)
                return (endRoom, endPoint)
            }
            if(roomObj is ThingJoke){
                let thing = roomObj as ThingJoke
                let endPoint:CGPoint = thing.GetJokePosition(char)
                return (endRoom, endPoint)
            }
        }
        let endRoom:Room? = scene.ActualLevel!.GetRoomInSceenPoint(touch)
        if(endRoom == nil){
            return (nil, nil)
        }
        let endPoint:CGPoint = CGPointMake(touch.x, endRoom!.FloorPosition)
        return (endRoom, endPoint)
    }
    
    
}


