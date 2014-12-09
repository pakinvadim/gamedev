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
    
    var WalkDown:CCAnimation?
    var WalkLeft:CCAnimation?
    var WalkRight:CCAnimation?
    var WalkUp:CCAnimation?
    
    var StandDownAction:CCAction?
    var StandLeftAction:CCAction?
    var StandRightAction:CCAction?
    var StandUpAction:CCAction?
    
    var BreatheAction:CCAction?
    
    var DoorLeftInAction:CCAction?
    var DoorLeftOutAction:CCAction?
    var DoorRightInAction:CCAction?
    var DoorRightOutAction:CCAction?
    var DoorTopInAction:CCAction?
    var DoorTopOutAction:CCAction?
    
    var PermanentLogics:[LogicBase] = [LogicBase]()
    var CurrentTasks:[TaskBase] = [TaskBase]()

    override init(scene:IntroScene) {
        super.init(scene: scene)
        anchorPoint = CGPointMake(0, 1)
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
        var permanentLogic:LogicBase? = GetPermanentLogic()
        if(permanentLogic != nil){
            let tasks = permanentLogic!.GetTasks(Scene!, char: self)
            AddCurrentTasks(tasks)
        }
    }
    
    func CanDo() -> Bool{
        self.stopAllActions()
        return true;
    }
    
    func GetCurrentTask() -> (Task:TaskBase?, Empty:Bool){
        var lastTask:TaskBase? = CurrentTasks.last
        if(lastTask == nil){
            return (nil, true)
        }
        
        if(lastTask!.Status == ActStatus.Run){
            return (nil, false)
        }
        if(lastTask!.Status == ActStatus.Done){
            CurrentTasks.removeLast()
            return GetCurrentTask()
        }
        
        var runTask:TaskBase? = CurrentTasks.FirstOrDefault({t in t.Status == ActStatus.Run})
        if(runTask != nil){
            if(!runTask!.CanStop){
                return(nil, false)
            }
            stopAction(runTask!.Action)
            CurrentTasks.IndexOf(runTask!)!
            CurrentTasks.removeRange(Range(start: 0, end: CurrentTasks.IndexOf(runTask!)! + 1))
        }
        return (lastTask, false)
    }
    
    func GetPermanentLogic() -> LogicBase?{
        if(PermanentLogics.count == 0){
            return nil
        }
        PermanentLogics.ForEach({l in if(l.Status == ActStatus.Run){ l.Status = ActStatus.None }})
        
        var nextLogic:LogicBase? = PermanentLogics.FirstOrDefault({ l in l.Status == ActStatus.None })
        if(nextLogic == nil){
            PermanentLogics.ForEach({l in l.Status = ActStatus.None})
            nextLogic = PermanentLogics.first
        }
        return nextLogic
        /*var nextTask:TaskBase? = PermanentTasks.LastOrDefault({t in t.Status == ActStatus.None})
        if(nextTask == nil){
            PermanentTasks.ForEach({t in t.Status = ActStatus.None})
            nextTask = PermanentTasks.last
        }
        return nextTask*/
        /*var allDone = true
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
        return nil*/
    }
    
    func GoTo(location:CGPoint){
        println("GoTo")
        var tasks = GoToManager.GoToLocation(Scene!, char: self, location: location)
        AddCurrentTasks(tasks)
    }
    
    func AddCurrentTasks(tasks:[TaskBase]){
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
    
    var Way:WayInfoManager?
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
