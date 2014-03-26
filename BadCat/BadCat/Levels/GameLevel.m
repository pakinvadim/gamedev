//
//  GameLevel.m
//  TestAnimate
//
//  Created by Pakinvadim on 11.11.13.
//  Copyright (c) 2013 CoonStudio. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel
{
    CGPoint _touchBegan_PointOfTouch;
    CGPoint _touchBegan_PointOfLayer;
}
CCLabelTTF *tditle;
-(id) init
{
    if( self=[super initWithColor:ccc4(255, 255, 255, 100)] )
    {
        self.touchEnabled = YES;
        self.anchorPoint = ccp(0.0f, 0.0f);
        self.roomArray = [[NSMutableArray alloc] init];
        CGSize ss = CGSizeMake(600, 80);
        
        tditle = [CCLabelTTF labelWithString:@"" dimensions:ss  alignment:UITextAlignmentLeft fontName: @"Arial"  fontSize:7];
        tditle.color = ccBLACK;
        [tditle setAnchorPoint:ccp(0, 0)];
        tditle.position =  ccp( 0 , -50);
        [self addChild:tditle z:1000];
    }
    
    return self;
}

-(void) addRoom:(Room*)room
{
    [self addChild:room z:0];
    [self.roomArray addObject:room];
}

-(Room*)GetRoomWithNumber:(int)roomNumber{
    for(Room* room in self.roomArray){
        if(room.numberRoom == roomNumber){
            return room;
        }
    }
    return nil;
}

-(Room*) GetRoomInPoint:(CGPoint) point{
    for(Room *room in self.roomArray){
        CGRect rectRoom = CGRectMake(room.position.x+self.position.x,room.position.y+self.position.y,
                                     [room boundingBox].size.width,[room boundingBox].size.height);
        /*CGRect rectRoom = CGRectMake((room.position.x+self.position.x)*self.scale,(room.position.y+self.position.y)*self.scale,
                                     [room boundingBox].size.width*self.scale,[room boundingBox].size.height *self.scale);*/
        if(CGRectContainsPoint(rectRoom, point)){
            return room;
        }
    }
    return nil;
}
-(Door*) GetDoorInPoint:(CGPoint) point{
    for(Room *room in self.roomArray){
        for (Door *door in room.doors) {
            CGRect rectDoor = CGRectMake( self.position.x + room.position.x + door.position.x + door.VisualIndentDoor
                                         ,self.position.y + room.position.y + door.position.y,
                                         door.Width, door.Height);
            if(CGRectContainsPoint(rectDoor, point)){
                NSLog([NSString stringWithFormat:@"touch door with direct: %d in room %d",door.direct,room.numberRoom]);
                return door;
            }
        }
    }
    return nil;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //CGPoint location = [touch locationInView:[touch view]];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    location = [[CCDirector sharedDirector] convertToGL:location];
    CCLOG(@"Touch BEGAN");
    _touchBegan_PointOfTouch = location;
    _touchBegan_PointOfLayer = self.position;
    [self up];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Выбираем касание, с которым будем работать
    UITouch *touch = [touches anyObject];
    //CGPoint location = [touch locationInView:[touch view]];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    if (_touchBegan_PointOfTouch.x == location.x && _touchBegan_PointOfTouch.y == location.y)
    {
        [self.cat GoTo:location];
        CCLOG(@"CanGO");
    }
    [self up];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray* allTouches = [[event allTouches] allObjects];
    if(touches.count == 2){
        UITouch* touchOne = [allTouches objectAtIndex:0];
        UITouch* touchTwo = [allTouches objectAtIndex:1];
        CGPoint touchLocationOne = [touchOne locationInView: [touchOne view]];
        CGPoint touchLocationTwo = [touchTwo locationInView: [touchTwo view]];
        CGPoint previousLocationOne = [touchOne previousLocationInView: [touchOne view]];
        CGPoint previousLocationTwo = [touchTwo previousLocationInView: [touchTwo view]];
        
        CGFloat currentDistance = sqrt(pow(touchLocationOne.x - touchLocationTwo.x, 2.0f) + pow(touchLocationOne.y - touchLocationTwo.y, 2.0f));
        CGFloat previousDistance = sqrt(pow(previousLocationOne.x - previousLocationTwo.x, 2.0f) + pow(previousLocationOne.y - previousLocationTwo.y, 2.0f));
        
        CGFloat distanceDelta = currentDistance - previousDistance;
        CGPoint pinchCenter = ccpMidpoint(touchLocationOne, touchLocationTwo);
        //CCLOG(@"DD %f PC %f %f",distanceDelta,pinchCenter.x,pinchCenter.y);
        pinchCenter = [self convertToNodeSpace:pinchCenter];
        [self scale: distanceDelta  scaleCenter:pinchCenter];/*0.00131*/
    }
    else if(touches.count == 1){
        UITouch *touch = [touches anyObject];
        CGPoint location = [self convertTouchToNodeSpace:touch];
        //CGPoint previousLocation = [touch previousLocationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        //previousLocation =
        //location = [[CCDirector sharedDirector] convertToGL:location];
        
        //for(Room *room in self.roomArray)
        {
            self.position = ccp(_touchBegan_PointOfLayer.x + (location.x - _touchBegan_PointOfTouch.x)
                                ,_touchBegan_PointOfLayer.y + (location.y - _touchBegan_PointOfTouch.y) );
        }
    }
    [self up];
    //CCLOG(@"move d");
}

- (void) scale:(float) distanceDelta scaleCenter:(CGPoint) scaleCenter {
    
    // Get the original center point.
    CGPoint oldCenterPoint = ccp(scaleCenter.x * self.scale, scaleCenter.y * self.scale);
    
    // Set the scale.
    self.scale += distanceDelta * 0.00131f;
    
    // Get the new center point.
    CGPoint newCenterPoint = ccp(scaleCenter.x * self.scale, scaleCenter.y * self.scale);
    
    // Then calculate the delta.
    CGPoint centerPointDelta  = ccpSub(oldCenterPoint, newCenterPoint);
    CCLOG(@"old %f %f new %f %f",oldCenterPoint.x,oldCenterPoint.y,newCenterPoint.x,newCenterPoint.y);
    // Now adjust your layer by the delta.
    self.position = ccpAdd(self.position, ccp(centerPointDelta.x ,centerPointDelta.y ));
}

-(void) up{
    NSString* s = @"";
    s = [NSString stringWithFormat:@"%@ _touchBegan_PointOfLayer(%0.2f   --   %0.2f)  -  ",s , _touchBegan_PointOfLayer.x ,_touchBegan_PointOfLayer.y];
    s = [NSString stringWithFormat:@"%@%@", s, @"\n"];
    s = [NSString stringWithFormat:@"%@ _touchBegan_PointOfTouch(%0.2f   --   %0.2f)  -  +",s , _touchBegan_PointOfTouch.x ,_touchBegan_PointOfTouch.y];
    s = [NSString stringWithFormat:@"%@%@", s, @"\n"];
    s = [NSString stringWithFormat:@"%@ L(%0.2f   --   %0.2f)  -  ",s , self.position.x, self.position.y];
    s = [NSString stringWithFormat:@"%@%@", s, @"\n"];
    for(Room* room in self.roomArray){
        s = [NSString stringWithFormat:@"%@ R%d(x%0.2f y%0.2f)  - ",s ,room.numberRoom, room.position.x];
        for(Door* d in room.doors){
            s = [NSString stringWithFormat:@"%@ D%d(x%0.2f y%0.2f - w%0.2f h%0.2f)",s ,d.direct, d.position.x, d.position.y, d.Width, d.Height];
        }
        s = [NSString stringWithFormat:@"%@%@", s, @"\n"];
        [tditle setString:s];
    }
    tditle.position =  ccp( -self.position.x, -self.position.y);
}
@end
