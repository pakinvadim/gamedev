//
//  GoToCenterRoomLogic.swift
//  GrumpyCat
//
//  Created by admin on 11.12.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class GoToCenterRoomLogic : LogicBase {
    var RoomInst:Room?
    
    init(room:Room) {
        super.init()
        RoomInst = room
    }
    
    override func GetLogicTasks(scene:IntroScene, char:GameChar) -> [TaskBase] {
        return GoToManager.GoToLocation(scene, char: char, location: RoomInst!.Center)
    }
}