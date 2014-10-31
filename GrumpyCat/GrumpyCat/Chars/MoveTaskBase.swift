//
//  MoveTaskBase.swift
//  GrumpyCat
//
//  Created by admin on 20.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class MoveTaskBase: TaskBase{
    
    override init(){
        super.init()
    }
    
    /*func GetCharMoveAnimation(char:GameChar, direct: MoveDirect, start:CGFloat, end:CGFloat) -> CCAction? {
        if(start == end){
                return nil;
        }
        
        var endPoint:CGPoint?
        var duration:Double = Double(abs(start - end) / char.Speed)
        var animate:CCActionAnimate?
        if(direct == MoveDirect.X){
            endPoint = CGPointMake(end, char.position.y)
            if(start < end){ //RIGHT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkRight) as CCActionAnimate
                Flip = true
            }
            else if(start > end){ //LEFT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkLeft) as CCActionAnimate
            }
        }
        else if (direct == MoveDirect.Y) {
            endPoint = CGPointMake(char.position.x, end)
            if(start < end){ //TOP
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkUp) as CCActionAnimate
            }
            else if(start > end){ //BOTTON
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkDown) as CCActionAnimate
            }
        }
        
        var move:CCActionMoveTo = CCActionMoveTo.actionWithDuration(duration, position: endPoint!) as CCActionMoveTo
        return CCActionSpawn.actionWithArray([move, animate!]) as CCActionSpawn
    }*/
    
    func GetCharMoveAnimation(char:GameChar, direct: MoveDirect, start:CGPoint, end:CGPoint) -> CCAction? {
        if((direct == MoveDirect.X && start.x == end.x) ||
            (direct == MoveDirect.Y && start.y == end.y)){
                return nil;
        }
        var d : CCTime?
        var duration:Double = 0
        var animate:CCActionAnimate?
        if(direct == MoveDirect.X){
            duration = Double(abs(start.x - end.x) / char.Speed)
            if(start.x < end.x){ //RIGHT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkRight) as? CCActionAnimate
                Flip = true
            }
            else if(start.x > end.x){ //LEFT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkLeft) as? CCActionAnimate
            }
        }
        else if (direct == MoveDirect.Y) {
            duration = Double(abs(start.y - end.y) / char.Speed)
            if(start.y < end.y){ //TOP
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkUp) as? CCActionAnimate
            }
            else if(start.y > end.y){ //BOTTON
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkDown) as? CCActionAnimate
            }
        }
        var move:CCActionMoveTo = CCActionMoveTo.actionWithDuration(duration, position: end) as CCActionMoveTo
        
        return CCActionSpawn.actionWithArray([move, animate!]) as CCActionSpawn
    }
    
    func AddAction(action:CCAction?, inout array:[CCAction]){
        if(action != nil){
            array.append(action!)
        }
    }
}
