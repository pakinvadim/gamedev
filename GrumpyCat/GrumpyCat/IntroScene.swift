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
    
    var ActualLevel: GameLevel?
    
    override init() {
        super.init()
        ActualLevel = Level1(scene: self)
        addChild(ActualLevel)
        userInteractionEnabled = true
        multipleTouchEnabled = true;
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
