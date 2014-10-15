//
//  IntroScene.swift
//  GrumpyCat
//
//  Created by CoonStudio on 7/27/14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class IntroScene : CCScene {

    override init() {
        super.init()
        var level1 = Level1()
        self.addChild(level1)
        self.userInteractionEnabled = true
        self.multipleTouchEnabled = true;
        //self.touchesBegan()
        //self.touchBegan(<#touch: UITouch!#>, withEvent: <#UIEvent!#>)
        /*let background = CCNodeColor.nodeWithColor(
            CCColor(red:0.2, green:0.2, blue:0.2, alpha:1.0)) as CCNodeColor
        self.addChild(background)

        let label = CCLabelTTF(string:"CoonStudio", fontName:"Chalkduster",
            fontSize:36)
        label.positionType = CCPositionType.Normalized
        label.color = CCColor.redColor()
        label.position = CGPointMake(0.5, 0.5)
        self.addChild(label)

        let helloWorldButton = CCButton(title:"[ Start ]", fontName:"Verdana-Bold",
            fontSize:18)
        helloWorldButton.positionType = CCPositionType.Normalized
        helloWorldButton.position = CGPointMake(0.5, 0.35)
        helloWorldButton.setTarget(self, selector:"onSpinningClicked:")
        self.addChild(helloWorldButton)*/
        //self.touchBegan(<#touch: UITouch!#>, withEvent: <#UIEvent!#>)
    }

    /*func onSpinningClicked(sender:AnyObject)
    {
        CCDirector.sharedDirector().replaceScene(HelloWorldScene(),
            withTransition: CCTransition(
                pushWithDirection: CCTransitionDirection.Left, duration: 1.0))
    }*/

    class func scene() -> CCScene {
        return IntroScene().scene
    }
    
    override func touchesBegan(touches: NSSet, withEvent event:UIEvent!){
        
    }
    
    override func touchBegan(touch: UITouch!, withEvent event: UIEvent!) {
        super.touchBegan(touch, withEvent: event)
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
