//
//  LogicBase.swift
//  GrumpyCat
//
//  Created by admin on 09.11.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class LogicBase {
    var Status:ActStatus = ActStatus.None
    
    init(){}
    
    func GetTasks(scene:IntroScene, char:GameChar) -> [TaskBase] {
        let RunTask:TaskBase = DoActionTask(action: CCActionCallBlock({ self.Status = ActStatus.Run }), name: "Run Logic")
        let DoneTask:TaskBase = DoActionTask(action: CCActionCallBlock({ self.Status = ActStatus.Done }), name: "Done Logic")
        
        var tasks = GetLogicTasks(scene, char: char)
        tasks.insert(DoneTask, atIndex: 0)
        tasks.append(RunTask)
        return tasks
    }
    
    func GetLogicTasks(scene:IntroScene, char:GameChar) -> [TaskBase] {
        return [TaskBase]()
    }
}
