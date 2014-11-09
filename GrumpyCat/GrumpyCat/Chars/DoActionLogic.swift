//
//  DoActionLogic.swift
//  GrumpyCat
//
//  Created by admin on 09.11.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class DoActionLogic : LogicBase{
    var Action:CCAction?
    var Name = ""
    var CanStop = false
    
    init(action:CCAction){
        super.init()
        Action = action
    }
    
    init(action:CCAction, name:String){
        super.init()
        Action = action
        Name = name
    }
    
    init(action:CCAction, canStop:Bool, name:String){
        super.init()
        Action = action
        CanStop = canStop
        Name = name
    }
    
    override func GetLogicTasks(scene: IntroScene, char: GameChar) -> [TaskBase] {
        return [DoActionTask(action: Action!, canStop: CanStop, name: Name)]
    }
}