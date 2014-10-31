//
//  MoveToXTask.swift
//  GrumpyCat
//
//  Created by admin on 22.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class MoveToXTask : TaskBase{
    let Start:CGFloat
    let End:CGFloat
    init(start:CGFloat, end:CGFloat){
        Start = start
        End = end
    }
    
    override func Populate(scene:IntroScene, char:GameChar){
        Populate(scene, char: char, action: MoveToXTask.GetAction(char, start:Start, end: End))
    }
    
    class func GetAction(char:GameChar, start:CGFloat, end:CGFloat) -> CCAction?{
        if(start == end){
            return nil;
        }
        var d : CCTime?
        var flipX:CCActionFlipX?
        var animate:CCActionAnimate?
        
        var duration:Double = abs(start - end) / char.Speed
        
        var move:CCActionMoveTo = CCActionMoveTo.actionWithDuration(duration, position: end) as CCActionMoveTo
        if(direct == MoveDirect.X){
            if(start.x < end.x){ //RIGHT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkRight) as CCActionAnimate
                flipX = CCActionFlipX.actionWithFlipX(true) as CCActionFlipX
                //self.flipX = YES;
            }
            else if(start.x > end.x){ //LEFT
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkLeft) as CCActionAnimate
                flipX = CCActionFlipX.actionWithFlipX(false) as CCActionFlipX
                //self.flipX = NO;
            }
        }
        else if (direct == MoveDirect.Y) {
            flipX = CCActionFlipX.actionWithFlipX(false) as CCActionFlipX
            //self.flipX = NO;
            if(start.y < end.y){ //TOP
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkUp) as CCActionAnimate
            }
            else if(start.y > end.y){ //BOTTON
                animate = CCActionAnimate.actionWithDuration(duration, animation:char.WalkDown) as CCActionAnimate
            }
        }
        /*CCFiniteTimeAction aa;
        [aa seta]
        CCRepeatForever a;*/
        //[animate setDuration:duration];
        //[animate step:5];
        //[animate elapsed:5];
        //[self.walkLeftAnimation setDelayPerUnit:0.3f];
        return CCActionSpawn.actionWithArray([flipX!, move, animate!]) as CCActionSpawn
    }
}
