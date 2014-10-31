//
//  BreatheTask.swift
//  GrumpyCat
//
//  Created by admin on 19.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation
let BreatheTaskTag = 25896546
class BreatheTask : TaskBase{
    
    override init(){
        super.init()
        Tag = BreatheTaskTag
    }
    
    override func Populate(scene:IntroScene, char:GameChar){
        Populate(scene, char:char, action:char.BreatheAction!)
    }
}
