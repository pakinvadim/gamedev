//
//  GameLevel.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class GameLevel : RootSprite {
    var TouchBegan_PointOfTouch:CGPoint?
    var TouchBegan_PointOfLevel:CGPoint?
    
    var Room9:Room?
    var Room10:Room?; var Room11:Room?; var Room12:Room?; var Room13:Room?;
    var Room21:Room?; var Room22:Room?; var Room23:Room?;
    var Room31:Room?
    var Rooms:[Room] = [Room]()
    var Cat:CatChar?
    var Man:ManChar?
    var Inventory:InventoryInfo?
    
    override init(scene:IntroScene){
        super.init(scene: scene)
        userInteractionEnabled = true
        multipleTouchEnabled = true;
        anchorPoint = CGPointMake(0, 0)
        
        Cat = CatChar(scene: scene)
        Man = ManChar(scene: scene)
        addChild(Cat, z:20)
        addChild(Man, z:20)
        
        Inventory = InventoryInfo(scene: scene)
        Scene!.addChild(Inventory, z:500)
    }
    
    func InitAll(){
        GameLevelInitHelper.AddRooms(self)
        GameLevelInitHelper.AddFloor(self)
        GameLevelInitHelper.AddTree(self)
        GameLevelInitHelper.AddGround(self)
    }
    
    func AddRoom(room:Room){
        addChild(room, z:10)
        Rooms.append(room)
    }
    
    func GetRoom(numb:Int) -> Room?{
        return Rooms.FirstOrDefault({r in r.Numb == numb})
    }
    
    func GetDoor(inRoomNum:Int, outRoomNum:Int) -> Door?{
        let inRoom:Room? = GetRoom(inRoomNum)
        let outRoom:Room? = GetRoom(outRoomNum)
        if(inRoom != nil && outRoom != nil){
            return inRoom!.GetDoor(outRoom!.Numb)
        }
        return nil;
    }
    
    func Click(location:CGPoint){
        if(Inventory!.Contain(location)){
            return
        }
        var locationInScene = self.convertToNodeSpace(location)
        println("Click \(locationInScene.x) \(locationInScene.y)")
        Cat!.GoTo(locationInScene)
    }
    
    func Move(location:CGPoint){
        if(Inventory!.Contain(TouchBegan_PointOfTouch!)){
            return
        }
        position = CGPointMake(TouchBegan_PointOfLevel!.x + (location.x - TouchBegan_PointOfTouch!.x)
            , TouchBegan_PointOfLevel!.y + (location.y - TouchBegan_PointOfTouch!.y))
    }
    
    func GetRoomInSceenPoint(point:CGPoint) -> Room?{
        for room:Room in Rooms {
            var rectRoom:CGRect = CGRectMake(room.position.x, room.position.y, room.Width, room.Height)
            if(CGRectContainsPoint(rectRoom, point)){
                return room;
            }
        }
        return nil;
    }
    
    func GetDoorInSceenPoint(point:CGPoint) -> Door?{
        for room:Room in Rooms{
            for door:Door in room.Doors {
                var doorPosition:CGPoint = door.Position;
                var doorSize:CGSize = CGSizeMake(door.Width, door.Height);
                if(door.Type == DoorType.Left){
                    doorSize.width /= 2.0;
                } else if(door.Type == DoorType.Right){
                    doorSize.width /= 2.0;
                    doorPosition.x += doorSize.width;
                } else if(door.Type == DoorType.Top){
                    var topIdent:CGFloat = 55.0;
                    doorSize.height -= topIdent;
                    doorPosition.y += topIdent;
                }
                var rectDoor:CGRect = CGRectMake(doorPosition.x, doorPosition.y, doorSize.width, doorSize.height);
                if(CGRectContainsPoint(rectDoor, point)){
                    println("touch door with direct: \(door.Direct) in room \(room.Numb)")
                    return door;
                }
            }
        }
        return nil;
    }
    
    func GetThingInSceenPoint(point:CGPoint) -> ThingBase?{
        for room:Room in Rooms{
            for thing:ThingBase in room.Things {
                var thingPosition:CGPoint = thing.Position;
                var rectDoor:CGRect = CGRectMake(thingPosition.x, thingPosition.y, thing.Width, thing.Height);
                
                if(CGRectContainsPoint(rectDoor, point)){
                    println("touch thing: \(thing)")
                    return thing;
                }
            }
        }
        return nil;
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        var location:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touches.anyObject() as UITouch);
        TouchBegan_PointOfTouch = location
        TouchBegan_PointOfLevel = position
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        var location:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touches.anyObject() as UITouch)
        if (TouchBegan_PointOfTouch!.x == location.x && TouchBegan_PointOfTouch!.y == location.y){
            Click(location)
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        var allTouches = event.allTouches()?.allObjects
        if(touches.count == 2){
            TouchScale(allTouches!)
        }
        else if(touches.count == 1){
            let location:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touches.anyObject()! as UITouch)
            Move(location)
        }
    }
    
    func TouchScale(touches: [AnyObject]){
        var touchOne:UITouch = touches[0] as UITouch
        var touchTwo:UITouch = touches[1] as UITouch
        var touchLocationOne:CGPoint = touchOne.locationInView(touchOne.view)
        var touchLocationTwo:CGPoint = touchTwo.locationInView(touchTwo.view)
        var preLocationOne:CGPoint = touchOne.previousLocationInView(touchOne.view)
        var preLocationTwo:CGPoint = touchTwo.previousLocationInView(touchTwo.view)
        
        var curDistance:Float = sqrtf(powf(Float(touchLocationOne.x - touchLocationTwo.x), 2.0) + powf(Float(touchLocationOne.y - touchLocationTwo.y), 2.0))
        var preDistance:Float = sqrtf(powf(Float(preLocationOne.x - preLocationTwo.x), 2.0) + powf(Float(preLocationOne.y - preLocationTwo.y), 2.0))
        
        var distanceDelta:Float = curDistance - preDistance
        var center:CGPoint = ccpMidpoint(touchLocationOne, touchLocationTwo)
        //CCLOG(@"DD %f PC %f %f",distanceDelta,pinchCenter.x,pinchCenter.y);
        center = self.convertToNodeSpace(center)
        //TouchScale(distanceDelta, center: pinchCenter)/*0.00131*/
        // Get the original center point.
        var oldCenterPoint:CGPoint = CGPointMake(center.x * CGFloat(scale), center.y * CGFloat(scale))
        scale += distanceDelta * 0.00131
        // Get the new center point.
        var newCenterPoint:CGPoint = CGPointMake(center.x * CGFloat(scale), center.y * CGFloat(scale))
        
        // Then calculate the delta.
        var centerPointDelta:CGPoint  = ccpSub(oldCenterPoint, newCenterPoint)
        //println("old \(oldCenterPoint.x) \(oldCenterPoint.y) new \(newCenterPoint.x) \(newCenterPoint.y)")
        // Now adjust your layer by the delta.
        position = ccpAdd(self.position, CGPointMake(centerPointDelta.x ,centerPointDelta.y ));
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}