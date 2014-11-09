//
//  GoToRoomObjectLogic.swift
//  GrumpyCat
//
//  Created by admin on 09.11.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class GoToRoomObjectLogic : LogicBase {
    var Object:RoomObject?
    
    init(object:RoomObject) {
        super.init()
        Object = object
    }
    
    override func GetLogicTasks(scene:IntroScene, char:GameChar) -> [TaskBase] {
        return GoToManager.GoToLocation(scene, char: char, location: Object!.CenterPosition)
    }
}