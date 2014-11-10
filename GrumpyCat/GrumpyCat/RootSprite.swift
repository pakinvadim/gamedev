//
//  RootSprite.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class RootSprite : CCSprite {
    var Scene:IntroScene?
    var WinSize:CGSize?

    init(scene:IntroScene) {
        super.init()
        Scene = scene;
        up()
    }
    
    init(scene: IntroScene, imageNamed imageName: String!) {
        super.init(imageNamed: imageName)
        Scene = scene;
        WinSize = CCDirector.sharedDirector().viewSize()
        up()
    }
    
    class func GetActionNew(name: String, frameCount: Int, delay: CGFloat) -> CCAction{
        let anim:CCAnimation = GetAnimationNew(name, frameCount:frameCount, delay:delay)
        return CCActionAnimate.actionWithAnimation(anim) as CCAction
    }
    
    class func GetAnimationNew(name: String, frameCount: Int, delay: CGFloat) -> CCAnimation{
        var arr:[Int] = [Int](1...frameCount)
        return GetAnimationNew(name, frameRange: arr, delay: delay);
    }
    
    class func GetAnimationNew(name: String, frameRange: [Int], delay:CGFloat) -> CCAnimation{
        var tempFrames = [CCSpriteFrame]()
        for i in frameRange {
            let fileName = frameRange.count != 1 ? "\(name) (\(i)).png" : "\(name).png"
            let frame = CCSpriteFrame.frameWithImageNamed(fileName) as CCSpriteFrame
            tempFrames.append(frame)
        }
        return CCAnimation.animationWithSpriteFrames(tempFrames, delay: Float(delay)) as CCAnimation
    }
    
    class func GetAction(name: String, frameCount: Int, delay: CGFloat, wight: CGFloat, hight: CGFloat) -> CCAction{
        let anim:CCAnimation = GetAnimation(name, frameCount:frameCount, delay:delay, wight:wight, hight:hight)
        return CCActionAnimate.actionWithAnimation(anim) as CCAction
    }
    
    class func GetAnimation(name: String, frameCount: Int, delay: CGFloat, wight: CGFloat, hight: CGFloat) -> CCAnimation{
        var arr:[Int] = [Int](0...frameCount-1)
        return GetAnimation(name, frameRange: arr, delay: delay, wight: wight, hight: hight);
    }
    
    class func GetAnimation(name: String, frameRange: [Int], delay:CGFloat, wight:CGFloat, hight:CGFloat) -> CCAnimation{
        var tempFrames = [CCSpriteFrame]()
        for i in frameRange {
            let frame = CCSpriteFrame.frameWithImageNamed("\(name)\(i).png") as CCSpriteFrame
            var rect = CGRectMake(0, 0, wight/2, hight/2)
            /*let frame = CCSpriteFrame.frameWithTextureFilename("\(name)\(i).png",
            rectInPixels: rect,
            rotated: false,
            offset:CGPointZero,
            originalSize:rect.size
            ) as CCSpriteFrame*/
            tempFrames.append(frame)
        }
        return CCAnimation.animationWithSpriteFrames(tempFrames, delay: Float(delay)) as CCAnimation
    }

    
    var ttf1:CCLabelTTF?
    var rectWithBorder = CCDrawNode();
    func up(){
        ttf1 = CCLabelTTF()//("", "Helvetica", 12, CCSizeMake(245, 32), CCTextAlignmentCenter);
        ttf1?.anchorPoint = CGPointMake(0,0)
        addChild(ttf1)
        addChild(rectWithBorder);

    }
    
    override func update(delta: CCTime) {
        //ttf1!.string = "\(position.x) : \(position.y)"
        
        /*var b = boundingBox()
        let vertices:UnsafePointer<CGPoint> = UnsafePointer([
            CGPoint(x: 0,y: b.height),
            CGPoint(x: b.width,y: b.height),
            CGPoint(x: b.width,y: 0),
            CGPoint(x: 0,y: 0)])
        
        rectWithBorder.clear()
        rectWithBorder.drawPolyWithVerts(vertices, count: 4,
            fillColor: CCColor(red: 255,green: 255,blue: 255,alpha: 0),
            borderWidth: 1,
            borderColor: CCColor(red: 1,green: 0,blue: 0,alpha: 1));*/
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}