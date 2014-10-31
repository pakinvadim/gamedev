//
//  GameChar.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class GameChar : RootSprite {
    var Speed: CGFloat = 250
    var Type:BotType?
    
    var BreatheAction:CCAction?
    var Breathe:CCAnimation?
    
    var WalkDown:CCAnimation?
    var WalkLeft:CCAnimation?
    var WalkRight:CCAnimation?
    var WalkUp:CCAnimation?
    
    var DoorLeftIn:CCAnimation?
    var DoorLeftOut:CCAnimation?
    var DoorRightIn:CCAnimation?
    var DoorRightOut:CCAnimation?
    var DoorTopIn:CCAnimation?
    var DoorTopOut:CCAnimation?
    
    var PermanentTasks:[TaskBase] = [TaskBase]()
    var CurrentTasks:[TaskBase] = [TaskBase]()

    override init(scene:IntroScene) {
        super.init(scene: scene)
        self.schedule(Selector("Myupdate"), interval: 0.05)
    }
    
    func Myupdate() {
        //println("up")
        var result = GetCurrentTask()
        if(result.Task != nil && CanDo()){
            result.Task!.Populate(Scene!, char: self)
            return
        }
        if(!result.Empty){
            return;
        }
        var permentTask:TaskBase? = GetPermentTask()
        if(permentTask != nil){
            permentTask!.Populate(Scene!, char: self)
        }
    }
    
    func CanDo() -> Bool{
        self.stopAllActions()
        PermanentTasks.ForEach({t in if(t.Status == TaskStatus.Run){t.Status = TaskStatus.None}})
        return true;
    }
    
    func GetCurrentTask() -> (Task:TaskBase?, Empty:Bool){
        var lastTask:TaskBase? = CurrentTasks.last
        if(lastTask == nil){
            return (nil, true)
        }
        
        if(lastTask!.Status == TaskStatus.Run){
            return (nil, false)
        }
        if(lastTask!.Status == TaskStatus.Done){
            CurrentTasks.removeLast()
            return GetCurrentTask()
        }
        
        var runTask:TaskBase? = CurrentTasks.FirstOrDefault({t in t.Status == TaskStatus.Run})
        if(runTask != nil){
            if(!runTask!.CanStop){
                return(nil, false)
            }
            stopAction(runTask!.Action)
            CurrentTasks.IndexOf(runTask!)!
            CurrentTasks.removeRange(Range(start: 0, end: CurrentTasks.IndexOf(runTask!)! + 1))
        }
        return (lastTask, false)
        /*for (index:Int, task:TaskBase) in enumerate(CurrentTasks){
            if(task.Status == TaskStatus.Run){
                return (nil, false)
            }
        }
        var task:TaskBase? = CurrentTasks.last
        while (task != nil && task!.Status == TaskStatus.Done) {
            CurrentTasks.removeLast()
            task = CurrentTasks.last
        }
        if(task == nil){
            return (nil, true)
        }
        return (task!, false)*/
    }
    
    func GetPermentTask() -> TaskBase?{
        var allDone = true
        for task:TaskBase in PermanentTasks{
            if(task.Status == TaskStatus.Run){
                return nil
            }
            if(task.Status != TaskStatus.Done){
                allDone = false
            }
        }
        if(allDone){
            for task:TaskBase in PermanentTasks{
                task.Status = TaskStatus.None
            }
        }
        for task:TaskBase in PermanentTasks{
            if(task.Status == TaskStatus.None){
                return task
            }
        }
        return nil
    }
    
    func GoTo(location:CGPoint){
        println("GoTo")
        var tasks = GoToPointLogic.GetActions(Scene!, char: self, touch: location)
        for task in tasks{
            CurrentTasks.append(task)
        }
    }
    
    func BindToRoom(number : Int) {
        let level = parent as GameLevel
            for room:Room in level.Rooms{
                if(room.Numb == number){
                    position = CGPointMake(room.Center.x, CGFloat(room.FloorPosition))
                }
            }
    }
    
    var Way:WayInfo?
    var RouteRun:Bool = false
    
    
    func GetActualRoom() -> Room{
        var room:Room? = Scene!.ActualLevel!.GetRoomInSceenPoint(position)
        return room!
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
