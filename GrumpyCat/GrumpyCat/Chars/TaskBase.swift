//
//  TaskBase.swift
//  GrumpyCat
//
//  Created by admin on 19.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

func == (lhs:TaskBase,rhs:TaskBase) -> Bool { return lhs === rhs }

class TaskBase : Equatable{
    var Tag:Int = 0
    var Flip:Bool = false
    var Status:TaskStatus = TaskStatus.None
    var DoneBlock:CCActionCallBlock?
    var CanStop:Bool = true
    var Action:CCAction?
    var Name:String = ""
    
    init(){
        DoneBlock = CCActionCallBlock({ self.Status = TaskStatus.Done })
    }
    
    func Populate(scene:IntroScene, char:GameChar){}
    
    func Populate(scene:IntroScene, char:GameChar, action:CCAction?){
        if(action == nil){
            println("\(self) \(Name) is nil")
            Status = TaskStatus.Done
        } else {
            println("\(self) \(Name) is run")
            Status = TaskStatus.Run
            char.flipX = Flip
            
            Action = CCActionSequence.actionWithArray([action!, DoneBlock!]) as CCAction
            Action!.tag = Tag
            char.runAction(Action)
        }
    }
}