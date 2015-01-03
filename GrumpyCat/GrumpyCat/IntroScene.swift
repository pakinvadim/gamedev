//
//  IntroScene.swift
//  GrumpyCat
//
//  Created by CoonStudio on 7/27/14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class IntroScene : CCScene {
    var TouchBegan_PointOfTouch:CGPoint?
    var TouchBegan_PointOfLevel:CGPoint?
    let ManAnchorPoint = CGPointMake(256, -480)
    let DoorLeftAnchorPoint = CGPointMake(0, -512)
    let DoorRightAnchorPoint = CGPointMake(512, -512)
    let DoorUpAnchorPoint = CGPointMake(256, -420)
    
    var ActualLevel: GameLevel?
    
    override init() {
        super.init()
        let back = CCNodeColor(color: CCColor(red: 0.65, green: 0.85, blue: 0.90), width: 4000, height: 3000)
        addChild(back, z: 0);
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("ManAngry.plist", anchor:ManAnchorPoint)
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("ManRepair.plist", anchor:ManAnchorPoint)
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("ManWalk.plist", anchor:ManAnchorPoint)
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("Shok.plist", anchor:ManAnchorPoint)
        
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("ManDoorLeft.plist", anchor:DoorLeftAnchorPoint)
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("ManDoorRight.plist", anchor:DoorRightAnchorPoint)
        CCSpriteFrameCache.sharedSpriteFrameCache().addSpriteFramesWithFile("ManDoorUp.plist", anchor:DoorUpAnchorPoint)
        
        ActualLevel = Level1(scene: self)
        addChild(ActualLevel)
        ActualLevel!.InitAll()
        userInteractionEnabled = true
        multipleTouchEnabled = true
        
        /*var s = CCSprite(imageNamed: "MWD (1).png")
        s.position = CGPointZero
        s.anchorPoint = CGPointMake(0,1)
        ActualLevel!.addChild(s, z:1000)*/
    }

    class func scene() -> CCScene {
        return IntroScene().scene
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        var location:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touches.anyObject() as UITouch);
        
        TouchBegan_PointOfTouch = location
        TouchBegan_PointOfLevel = ActualLevel!.position
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        var location:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touches.anyObject() as UITouch)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        var allTouches = event.allTouches()?.allObjects
        if(touches.count == 2){
        }
        else if(touches.count == 1){
        }
    }
}

extension CCPositionType {
    static var Normalized:CCPositionType {
        get { return CCPositionTypeMake(
            CCPositionUnit.Normalized,
            CCPositionUnit.Normalized,
            CCPositionReferenceCorner.BottomLeft) }
    }
}
