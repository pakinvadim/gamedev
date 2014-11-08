//
//  MoveInRoomTask.swift
//  GrumpyCat
//
//  Created by admin on 20.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class MoveInRoomTask : MoveTaskBase{
    var EndPoint:CGPoint
    var MoveUp:Bool
    
    init(point:CGPoint, moveUp:Bool){
        EndPoint = point
        MoveUp = moveUp
        super.init()
    }
    
    override func Populate(scene:IntroScene, char:GameChar){
        let action:CCAction? = GetMoveToPointAction(scene, char:char)
        Populate(scene, char:char, action:action)
    }
    
    func GetMoveToPointAction(scene:IntroScene, char:GameChar) -> CCAction?{
        var actionList:[CCAction] = [CCAction]();
        
        if(EndPoint.x == 0 && EndPoint.y == 0 || char.position == EndPoint) {
            return nil
        }
        let room:Room = char.GetActualRoom()
        let checkRoom = scene.ActualLevel?.GetRoomInSceenPoint(EndPoint)
        
        if(checkRoom == nil || room.Numb != checkRoom!.Numb){
            return nil
        }
        if (EndPoint.x > room.MaxRight) {
            EndPoint.x = room.MaxRight
        }
        else if(EndPoint.x < room.MaxLeft) {
            EndPoint.x = room.MaxLeft
        }
        
        let moveXStart:CGPoint = CGPointMake(char.position.x, room.FloorPosition)
        var moveXEnd:CGPoint = CGPointMake(EndPoint.x, room.FloorPosition)
        
        /*let moveDown = GetCharMoveAnimation(char, direct: MoveDirect.Y, start:char.position, end:moveXStart)
        let moveX = GetCharMoveAnimation(char, direct: MoveDirect.X, start:moveXStart, end:EndPoint)
        let moveUp = GetCharMoveAnimation(char, direct: MoveDirect.Y, start: moveUpStart, end: door!.EnterPosition)*/
        
        let moveDown:CCAction? = GetCharMoveAnimation(char, direct: MoveDirect.Y, start:char.position, end:moveXStart)
        let moveX:CCAction? = GetCharMoveAnimation(char, direct: MoveDirect.X, start:moveXStart, end:moveXEnd)
        let moveUp:CCAction? = MoveUp ? GetCharMoveAnimation(char, direct: MoveDirect.Y, start: moveXEnd, end: EndPoint) : nil
        
        AddAction(moveDown, array: &actionList)
        AddAction(moveX, array: &actionList)
        AddAction(moveUp, array: &actionList)
        
        if(actionList.count == 0){
            return nil
        }
        return CCActionSequence.actionWithArray(actionList) as CCAction
    }
}