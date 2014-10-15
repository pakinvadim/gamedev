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
    var TouchBegan_PointOfLayer:CGPoint?
    
    var Rooms:[Room] = [Room]()
    var Cat = CatChar()
    
    override init(){
        super.init()
        anchorPoint = ccp(0, 0)
    }
    
    func touchesBegan(touches:NSSet, event:UIEvent){
        var touch:UITouch = touches.anyObject() as UITouch
        var location:CGPoint = touch.locationInView(touch.view)
        //CGPoint location = [self convertTouchToNodeSpace:touch];
        location = CCDirector.sharedDirector().convertToGL(location)
        println("Touch BEGAN")
        TouchBegan_PointOfTouch = location;
        TouchBegan_PointOfLayer = position;
        //[self up];
    }
    
    func TouchesEnded(touches:NSSet, event:UIEvent) {
        
        // Выбираем касание, с которым будем работать
        var touch:UITouch = touches.anyObject() as UITouch
        var location:CGPoint = touch.locationInView(touch.view)
        //CGPoint location = [self convertTouchToNodeSpace:touch];
        location = CCDirector.sharedDirector().convertToGL(location)
        
        if (TouchBegan_PointOfTouch!.x == location.x && TouchBegan_PointOfTouch!.y == location.y){
            println("GO BEGAN")
            Cat.GoTo(location)
        }
        //[self up];
    }
    
    func TouchesMoved(touches:NSSet, event:UIEvent){
        var allTouches = event.allTouches()?.allObjects
        if(touches.count == 2){
            var touchOne:UITouch = allTouches![0] as UITouch
            var touchTwo:UITouch = allTouches![1] as UITouch
            var touchLocationOne:CGPoint = touchOne.locationInView(touchOne.view)
            var touchLocationTwo:CGPoint = touchTwo.locationInView(touchTwo.view)
            var preLocationOne:CGPoint = touchOne.previousLocationInView(touchOne.view)
            var preLocationTwo:CGPoint = touchTwo.previousLocationInView(touchTwo.view)
            
            var curDistance:Float = sqrtf(powf(Float(touchLocationOne.x - touchLocationTwo.x), 2.0) + powf(Float(touchLocationOne.y - touchLocationTwo.y), 2.0))
            var preDistance:Float = sqrtf(powf(Float(preLocationOne.x - preLocationTwo.x), 2.0) + powf(Float(preLocationOne.y - preLocationTwo.y), 2.0))
            
            var distanceDelta:Float = curDistance - preDistance
            var pinchCenter:CGPoint = ccpMidpoint(touchLocationOne, touchLocationTwo)
            //CCLOG(@"DD %f PC %f %f",distanceDelta,pinchCenter.x,pinchCenter.y);
            pinchCenter = self.convertToNodeSpace(pinchCenter)
            Scale(distanceDelta, center: pinchCenter)/*0.00131*/
        }
        else if(touches.count == 1){
            var touch:UITouch = touches.anyObject()! as UITouch
            var location:CGPoint = touch.locationInView(touch.view)
            //CGPoint previousLocation = [touch previousLocationInView:[touch view]];
            location = CCDirector.sharedDirector().convertToGL(location)
            //previousLocation =
            //location = [[CCDirector sharedDirector] convertToGL:location];
            
            //for(Room *room in self.roomArray)
            //{
            position = ccp(TouchBegan_PointOfLayer!.x + (location.x - TouchBegan_PointOfTouch!.x)
                    , TouchBegan_PointOfLayer!.y + (location.y - TouchBegan_PointOfTouch!.y))
            //}
        }
        //[self up];
        //CCLOG(@"move d");
    }
    
    func Scale(distanceDelta:Float, center:CGPoint) {
        // Get the original center point.
        var oldCenterPoint:CGPoint = ccp(center.x * CGFloat(scale), center.y * CGFloat(scale))
        scale += distanceDelta * 0.00131
        // Get the new center point.
        var newCenterPoint:CGPoint = ccp(center.x * CGFloat(scale), center.y * CGFloat(scale))
        
        // Then calculate the delta.
        var centerPointDelta:CGPoint  = ccpSub(oldCenterPoint, newCenterPoint)
        println("old \(oldCenterPoint.x) \(oldCenterPoint.y) new \(newCenterPoint.x) \(newCenterPoint.y)")
        // Now adjust your layer by the delta.
        self.position = ccpAdd(self.position, ccp(centerPointDelta.x ,centerPointDelta.y ));
    }
    
    func AddRoom(room:Room){
        addChild(room, z:0)
        Rooms.append(room)
    }
    
    func GetRoom(numb:Int) -> Room?{
        for room:Room in Rooms {
            if(room.Numb == numb){
                return room;
            }
        }
        return nil;
    }
    
    func GetRoomInSceenPoint(point:CGPoint) -> Room?{
        for room:Room in Rooms {
            var roomPosition:CGPoint = ccpAdd(position, ccpMult(room.position, CGFloat(scale)))
            /*CGRect rectRoom = CGRectMake(roomPosition.x ,roomPosition.y ,
            roomSize.width ,roomSize.height);*/
            
            var rectRoom:CGRect = CGRectMake(roomPosition.x, roomPosition.y,
                room.contentSize.width * CGFloat(scale), room.contentSize.height * CGFloat(scale));
            /*CGRect rectRoom = CGRectMake((room.position.x+self.position.x)*self.scale,(room.position.y+self.position.y)*self.scale,
            [room boundingBox].size.width*self.scale,[room boundingBox].size.height *self.scale);*/
            if(CGRectContainsPoint(rectRoom, point)){
                return room;
            }
        }
        return nil;
    }
    
    func GetDoorInSceenPoint(point:CGPoint) -> Door?{
        for room:Room in Rooms{
            for door:Door in room.Doors {
                var roomPosition:CGPoint = ccpAdd(position, ccpMult(room.position, CGFloat(scale)));
                var doorPosition:CGPoint = ccpAdd(roomPosition, ccpMult(door.position, CGFloat(scale)));
                var doorSize:CGSize = CGSizeMake(door.contentSize.width * CGFloat(scale), door.contentSize.height * CGFloat(scale));
                if(door.Type == DoorType.Left){
                    doorSize.width /= 2;
                } else if(door.Type == DoorType.Right){
                    doorSize.width /= 2;
                    doorPosition.x += doorSize.width;
                } else if(door.Type == DoorType.Top){
                    var topIdent:Float = 55.0 * scale;
                    doorSize.height -= topIdent;
                    doorPosition.y += topIdent;
                }
                var rectDoor:CGRect = CGRectMake(doorPosition.x, doorPosition.y
                    ,doorSize.width ,doorSize.height);
                /*CGRect rectDoor = CGRectMake( self.position.x + room.position.x + door.position.x + door.VisualIndentDoor
                ,self.position.y + room.position.y + door.position.y,
                door.Width, door.Height);*/
                if(CGRectContainsPoint(rectDoor, point)){
                    println("touch door with direct: \(door.Direct) in room \(room.Numb)")
                    return door;
                }
            }
        }
        return nil;
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}