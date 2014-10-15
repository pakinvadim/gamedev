//
//  RootSprite.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) 2014 CoonStudio. All rights reserved.
//

import Foundation

class RootSprite : CCSprite {
    let DoorAnimationDelay: Float = 0.1;
    var PositionGlobal:CGPoint {
        get{
            let level = parent as GameLevel;
            return ccpAdd(level.position, self.position);
        }
    }
    var PositionOnSceen:CGPoint {
        get{
            let level = parent as GameLevel;
            return ccpAdd(level.position, ccpMult(self.position, CGFloat(level.scale)));
        }
    }
    
    
    override init() {
        super.init()
    }
    
    func GetAnimation(name: String, frameCount: Int, delay: CGFloat, wight: CGFloat, hight: CGFloat) -> CCAnimation{
        var arr:[Int] = [Int](0...frameCount-1)
        return GetAnimation(name, frameRange: arr, delay: delay, wight: wight, hight: hight);
    }
    
    func GetAnimation(name: String, frameRange: [Int], delay:CGFloat, wight:CGFloat, hight:CGFloat) -> CCAnimation{
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
    
    func ConvertTouch(point:CGPoint) -> CGPoint{
        return ccp((0 - parent.position.x) + point.x, (0 - parent.position.y) + point.y);
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}