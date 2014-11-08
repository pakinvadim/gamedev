//
//  DoActionTask.swift
//  GrumpyCat
//
//  Created by admin on 28.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class DoActionTask : TaskBase {
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
    
    override func Populate(scene:IntroScene, char:GameChar){
        Populate(scene, char:char, action: Action)
    }
}
