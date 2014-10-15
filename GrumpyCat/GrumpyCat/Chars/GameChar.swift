//
//  GameChar.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class GameChar : RootSprite {
    var Speed: Float
    var StartRoomNumber: Int
    var Type:BotType?
    
    var WalkDown:CCAnimation?
    var WalkLeft:CCAnimation?
    var WalkRight:CCAnimation?
    var WalkUp:CCAnimation?
    var Stand:CCAnimation?
    
    var StandAnimate:CCActionAnimate?
    
    var DoorLeftIn:CCAnimation?
    var DoorLeftOut:CCAnimation?
    var DoorRightIn:CCAnimation?
    var DoorRightOut:CCAnimation?
    var DoorTopIn:CCAnimation?
    var DoorTopOut:CCAnimation?

    override init() {
        Speed = 250.0
        super.init()
    }
    
    func SetStartRoom(number:Int){
        StartRoomNumber = number
        let level = parent as GameLevel
        for room:Room in level.Rooms{
            if(room.Numb == StartRoomNumber){
                position = ccp(room.Center.x, CGFloat(room.FloorPosition))
            }
        }
    }
    
    func GetDurationBetween(start:CGPoint, end:CGPoint) -> Float{
        return Float(ccpDistance(start, end)) / self.Speed
    }
    
    func DoStand(){
        runAction(StandAnimate)
    }
    
    var Way:WayInfo?
    var RouteRun:Bool
    
    func GoTo(touch:CGPoint){
        let level:GameLevel = parent as GameLevel
        let actualRoom:Room = GetActualRoom()!
        let touchDoor:Door? = level.GetDoorInSceenPoint(touch) ////???????
        var endRoom:Room? = level.GetRoom(touchDoor!.Direct)
        var endPoint:CGPoint = ccp(0, 0)
        if(endRoom == nil){
            endRoom = level.GetRoomInSceenPoint(touch)
            endPoint = ccp(ConvertTouch(touch).x / CGFloat(level.scale), endRoom!.FloorPosition)
        }
        if(endRoom != nil){
            println("actual room number \(actualRoom.Numb)")
            println("walk room number \(endRoom!.Numb)")
            
            Way = GetWalkRouteTo(endRoom!, endPoint: endPoint, actualRoom: actualRoom)
            
            //for i in router2{ print("->\(i)")}
            if(!RouteRun){
                stopAllActions()
                GoRoute(self, route1: nil)
            }
        }
    }
    
    func GoRoute(sender:AnyObject, route1:[AnyObject]?){
        if(Way == nil || Way!.Empty){
            return;
        }
        RouteRun = true;
        var actionList:[CCAction] = [CCAction]();
        
        var room:Room = GetActualRoom()!;
        //CCSpawn* moveAnimate = nil;
        var moveDown:CCActionSpawn?
        var moveX:CCActionSpawn?
        var moveUp:CCActionSpawn?
        var enterInDoor:CCActionSpawn?
        
        var callbackAction:CCActionCallFunc?
        var endPosition:CGPoint
        
        if(Way!.Way.count == 1){
            endPosition = Route2!.first! as CGPoint
            Route2!.removeLast()
            if(endPosition.x != 0 && endPosition.y != 0) {
                if(endPosition.x > room.MaxRight) {
                    endPosition.x = room.MaxRight
                }
                else if(endPosition.x < room.MaxLeft) {
                    endPosition.x = room.MaxLeft
                }
                
                var moveXStart:CGPoint = ccp(position.x, room.FloorPosition)
                
                moveDown = GetCharMoveAnimation(MoveDirect.Y, start:position, end:moveXStart)
                moveX = GetCharMoveAnimation(MoveDirect.X, start:moveXStart, end:endPosition)
            }
        }
        else {
            var nextRoomNum:Int = Route2!.first! as Int
            println("Next room number \(nextRoomNum)")
            
            var level:GameLevel = parent as GameLevel;
            var door:Door? = room.GetDoor(nextRoomNum)
            var nextRoom:Room = level.GetRoom(nextRoomNum)!
            var nextDoor:Door? = nextRoom.GetDoor(room.Numb)
            
            if(door != nil && nextDoor != nil){
                var moveXStart:CGPoint = ccp(position.x, room.FloorPosition)
                var moveUpStart:CGPoint = ccp(door!.EnterPosition.x, room.FloorPosition)
                if (moveXStart != moveUpStart){//случай когда бот стоит уже возле двери
                    moveDown = GetCharMoveAnimation(MoveDirect.Y, start: position, end: moveXStart)
                    moveX = GetCharMoveAnimation(MoveDirect.X, start: moveXStart, end: moveUpStart)
                    moveUp = GetCharMoveAnimation(MoveDirect.Y, start: moveUpStart, end: door!.EnterPosition)
                }
                enterInDoor = GetDoorAnimation(door!, outDoor: nextDoor!)
                callbackAction = CCActionCallFunc.actionWithTarget(self, selector: Selector(GoRoute:routeData:) object:nil)
            }
            else {
                Route2!.removeAll()
            }
        }
        AddAction(moveDown, array:&actionList)
        AddAction(moveX, array:&actionList)
        AddAction(moveUp, array:&actionList)
        AddAction(enterInDoor, array:&actionList)
        AddAction(callbackAction, array:&actionList)
        Route2!.removeAtIndex(0)
        //[self runAction:moveAnimate];
        if(actionList.count != 0){
            runAction(CCActionSequence.actionWithArray(actionList) as CCAction)
        }
        if(Route2!.count == 0){
            RouteRun = false
            println("GO END")
        }
    }
    
    func GetCharMoveAnimation(direct: MoveDirect, start:CGPoint, end:CGPoint) -> CCActionSpawn? {
        if((direct == MoveDirect.X && start.x == end.x) ||
            (direct == MoveDirect.Y && start.y == end.y)){
                return nil;
        }
        var d : CCTime?
        var duration:Double = Double(GetDurationBetween(start, end: end))
        var flipX:CCActionFlipX?
        var animate:CCActionAnimate?
        var move:CCActionMoveTo = CCActionMoveTo.actionWithDuration(duration, position: end) as CCActionMoveTo
        if(direct == MoveDirect.X){
            if(start.x < end.x){ //RIGHT
                animate = CCActionAnimate.actionWithDuration(duration, animation:WalkRight) as CCActionAnimate
                flipX = CCActionFlipX.actionWithFlipX(true) as CCActionFlipX
                //self.flipX = YES;
            }
            else if(start.x > end.x){ //LEFT
                animate = CCActionAnimate.actionWithDuration(duration, animation:WalkLeft) as CCActionAnimate
                flipX = CCActionFlipX.actionWithFlipX(false) as CCActionFlipX
                //self.flipX = NO;
            }
        }
        else if (direct == MoveDirect.Y) {
            flipX = CCActionFlipX.actionWithFlipX(false) as CCActionFlipX
            //self.flipX = NO;
            if(start.y < end.y){ //TOP
                animate = CCActionAnimate.actionWithDuration(duration, animation:WalkUp) as CCActionAnimate
            }
            else if(start.y > end.y){ //BOTTON
                animate = CCActionAnimate.actionWithDuration(duration, animation:WalkDown) as CCActionAnimate
            }
        }
        /*CCFiniteTimeAction aa;
        [aa seta]
        CCRepeatForever a;*/
        //[animate setDuration:duration];
        //[animate step:5];
        //[animate elapsed:5];
        //[self.walkLeftAnimation setDelayPerUnit:0.3f];
        return CCActionSpawn.actions(flipX!, move, animate!)
    }
    
    func GetDoorAnimation(inDoor: Door, outDoor: Door) -> CCActionSpawn{
        var doorsArray:[Door] = [inDoor,outDoor]
        var runDoorsAnim:CCActionCallFunc = CCActionCallFunc.actionWithTarget(self, selector: "RunAnimationDoor") as CCActionCallFunc//@selector(RunAnimationDoor:doorsArray:) object:doorsArray)
        var animTime:CCDelayTime
        if(inDoor.Type == DoorType.Left || inDoor.Type == DoorType.Right){
            animTime = CCDelayTime.actionWithDuration(DoorAnimationDelay * Float(6))
        }
        else if(inDoor.Type == DoorType.Top){
            animTime = CCDelayTime.actionWithDuration(DoorAnimationDelay * Float(12)) //поднятие по лестнице длится дольше
        }
        var move:CCMoveTo = CCMoveTo.actionWithDuration(0, position: outDoor.EnterPosition)
        return CCActionSpawn.actions(CCSequence.actions(CCHide.action, move, runDoorsAnim, animTime, CCShow.action, nil) ,nil)
    }
    
    func RunAnimationDoor(sender:AnyOnject, doors:[Door]){
        if(doors == nil || doors.count != 2){
            return;
        }
        var animateIn:CCAnimation?
        var animateOut:CCAnimation?
        var inDoor:Door = doors[0]
        var outDoor:Door = doors[1]
        var stairsTime:CCDelayTime?
        if(inDoor.Type == DoorType.Left){
            animateIn = DoorLeftInAnimation
            animateOut = DoorRightOutAnimation
            stairsTime = CCDelayTime.actionWithDuration(0)
        }
        else if(inDoor.Type == DoorType.Right){
            animateIn = DoorRightInAnimation
            animateOut = DoorLeftOutAnimation
            stairsTime = CCDelayTime.actionWithDuration(0)
        }
        else if(inDoor.Type == DoorType.Top){
            animateIn = DoorTopInAnimation
            animateOut = DoorTopOutAnimation
            stairsTime = CCDelayTime.actionWithDuration(DoorAnimationDelay * Float(6));// задержка при поднятие по лестнице
        }
        inDoor.runAction(CCSequence actions(inDoor.Opening, inDoor.Closed, nil))
        inDoor.AnimationSprite.runAction(CCSequence.actions(CCShow.action, CCAnimate.actionWithAnimation(animateIn),CCHide.action, nil))
        outDoor.runAction(CCSequence actions(stairsTime, outDoor.Opening, outDoor.Closed, nil))
        outDoor.AnimationSprite.runAction(CCSequence.actions(stairsTime, CCShow.action, CCAnimate.actionWithAnimation(animateOut), CCHide.action ,nil))
    }
    
    func GetWalkRouteTo(endRoom:Room, endPoint:CGPoint, actualRoom:Room) -> WayInfo{
        var way:WayInfo = WayInfo()
        if (endRoom.Numb != actualRoom.Numb) // проверяем не нажали ли туже комнату
        {
            var level:GameLevel = parent as GameLevel
            var tempWay:[Int] = [Int]()
            GetWalkRouteTo(endRoom, actualRoom: actualRoom, level: level, way: &way, tempWay: &tempWay)
        }
        way.EndPoint = endPoint
        way.Populate()
        return way;
    }
    
    func GetWalkRouteTo(endRoom:Room, actualRoom:Room, level:GameLevel, inout way:WayInfo, inout tempWay:[Int]){
        /*NSArray *sortedRooms = [actualRoom.doors sortedArrayUsingComparator:^(Door* door1, Door* door2) {
        float door1Distance = [self DistanceBetween:door1 and:endRoom];
        float door2Distance = [self DistanceBetween:door2 and:endRoom];
        
        if (door1Distance < door2Distance) {
        return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (door1Distance > door2Distance) {
        return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
        }];*/
        
        for door:Door in actualRoom.Doors {
            var dir:Int = door.Direct
            tempWay.append(dir);
            if(dir == endRoom.Numb){
                way.Ways.append(tempWay)
            }
            else{
                if(!contains(way.CheckedRooms, dir)){
                    way.CheckedRooms.append(actualRoom.Numb)
                    GetWalkRouteTo(endRoom, actualRoom: level.GetRoom(dir)!, level: level, way: &way, tempWay: &tempWay)
                    
                    /*if([(NSNumber*)[routeNumRoom firstObject] integerValue] == endRoom.numberRoom)
                    {
                    [routeNumRoom addObject:[NSNumber numberWithInteger:dir]];
                    return routeNumRoom;
                    }*/
                }
            }
            tempWay.removeLast()
            //}
        }
    }
    
    func GetActualRoom() -> Room?{
        var level:GameLevel = parent as GameLevel
        return level.GetRoomInSceenPoint(PositionOnSceen)
    }
    
    func DistanceBetween(sprite1:CCSprite, sprite2:CCSprite) -> Float{
        return sqrtf(Float((sprite1.position.x * sprite2.position.x) + (sprite1.position.y * sprite1.position.y)))
    }
    
    func AddAction(action:CCAction?, inout array:[CCAction]){
        if(action != nil){
            array.append(action!)
        }
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}

class WayInfo {
    var EndPoint:CGPoint
    var Way:[Int] = [Int]()
    var Ways:[[Int]] = [[Int]]()
    var CheckedRooms:[Int] = [Int]()
    var Empty:Bool{get{return Ways.count == 0 && EndPoint.x == 0 && EndPoint.y == 0}}
    
    init(){}
    
    func Populate() {
        Way = Ways.first!
        for wayItem:[Int] in Ways{
            if(Way.count > wayItem.count){
                Way = wayItem;
            }
        }
    }
}
