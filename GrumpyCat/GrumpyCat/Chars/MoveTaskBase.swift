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
        var step:CGPoint = CGPointZero
        if(direct == MoveDirect.X){
            duration = Double(abs(start.x - end.x) / char.Speed)
            let distance: CGFloat = CGFloat(abs(start.x - end.x))
            if(start.x < end.x){ //RIGHT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkRight) as? CCActionAnimate
                step = CGPointMake(5, 0)
            }
            else if(start.x > end.x){ //LEFT
                
                ////????000
                let stepsCount:Int = Int(floor(distance / char.Step))
                //let fullStepsCount:Int = stepsCount / char.LeftStep.count
                var animArray:[CCAction] = [CCAction]()
                /*for i in 1...fullStepsCount{
                    char.LeftStep.ForEach({(s) -> () in animArray.append(s)})
                }*/
                var j = 0;
                for i in 1...stepsCount {
                    animArray.append(char.LeftStep[j])
                    j = j >= char.LeftStep.count-1 ? 0 : j+1
                }
                animArray.append(CCActionSpawn.actionWithArray([char.StandLeftAction,
                    CCActionMoveTo.actionWithDuration(0.001, position: end)]) as CCAction)
                //animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkLeft) as? CCActionAnimate
                return CCActionSequence.actionWithArray(animArray) as CCAction;
            }
        }
        else if (direct == MoveDirect.Y) {
            duration = Double(abs(start.y - end.y) / char.Speed*2)
            if(start.y < end.y){ //TOP
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkUp) as? CCActionAnimate
                step = CGPointMake(0, 5)
            }
            else if(start.y > end.y){ //BOTTON
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkDown) as? CCActionAnimate
                step = CGPointMake(0, -5)
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
