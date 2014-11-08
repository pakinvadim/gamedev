//
//  Inventory.swift
//  GrumpyCat
//
//  Created by admin on 26.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class InventoryInfo : UIBase {
    var TouchBegan_PointOfTouch:CGPoint?
    var TouchBegan_PointOfLevel:CGPoint?
    var Things:[ThingGet] = [ThingGet]()
    
    var MovingThing:ThingGet?
    var MovingThingOffset:CGPoint?
    var MovingDirect:MoveDirect?
    
    let ItemsIndent:CGFloat = 15
    //let ItemLeftIndentDefault:CGFloat = 15
    //let ItemRightIndentDefault:CGFloat = 15
    var ItemLeftOffset:CGFloat = 15
    var ItemBottonOffset:CGFloat = 5
    let ItemWidht:CGFloat = 78
    let ItemHeight:CGFloat = 100
    let ItemIdent:CGFloat = 5
    
    var MaxLeft:CGFloat = 0
    var MaxRight:CGFloat = 0
    
    var AllItemsWidth:CGFloat = 0
    
    init(scene:IntroScene){
        super.init(scene:scene, imageNamed: "inventory.jpg")
        userInteractionEnabled = true
        multipleTouchEnabled = true;
        position.x = (WinSize!.width / 2.0) - Width / 2.0
        MaxLeft = ItemsIndent
        MaxRight = Width - ItemsIndent
    }
    
    func AddThing(thing:ThingGet){
        Things.append(thing)
        UpdateItems()
        thing.ChangeImage()
        addChild(thing, z: 10)
        UpdateAllItemsWidht()
    }
    
    func DeleteThing(thing:ThingBase){
        UpdateAllItemsWidht()
    }
    
    func Click(location:CGPoint){
        
    }
    
    override func update(delta: CCTime) {
        if(MovingDirect == nil){
            if((ItemLeftOffset > MaxLeft || ItemLeftOffset < MaxRight - AllItemsWidth)
                && (ItemLeftOffset != MaxLeft && ItemLeftOffset != MaxRight - AllItemsWidth)){
                var rightPoint = ItemLeftOffset + AllItemsWidth
                if(abs(ItemLeftOffset - MaxLeft) <= 40){
                    ItemLeftOffset = MaxLeft
                }else if (ItemLeftOffset < MaxLeft && abs(rightPoint - MaxRight) <= 40){
                    ItemLeftOffset = MaxRight - AllItemsWidth
                }else if(ItemLeftOffset > MaxLeft || rightPoint > MaxRight){
                    ItemLeftOffset -= 40
                }else if(ItemLeftOffset < MaxLeft || rightPoint < MaxRight){
                    ItemLeftOffset += 40
                }
                UpdateItems()
            }
        }
    }
    
    func UpdateItems() {
        for var i:Int = 0; i < Things.count; i++  {
            Things[i].position = CGPointMake(ItemLeftOffset + ((ItemWidht + ItemIdent) * CGFloat(i)), ItemBottonOffset)
            Things[i].visible = Things[i].position.x + ItemWidht > MaxLeft && Things[i].position.x < MaxRight
        }
    }
    
    func TouchEnd(location:CGPoint){
        if(MovingThing != nil){
            UpdateItems()
            MovingThing = nil
        }
        MovingDirect = nil
    }
    
    func Move(location:CGPoint, preLocation:CGPoint){
        let locNode = convertToNodeSpace(location)
        let preLocNode = convertToNodeSpace(preLocation)
        if(MovingDirect == nil){
            let xStep:CGFloat = abs(location.x - preLocation.x)
            let yStep:CGFloat = abs(location.y - preLocation.y)
            MovingDirect = yStep / xStep > 0.4 ? MoveDirect.Y : MoveDirect.X
            println("\(xStep) \(yStep)")
        }
        if(MovingThing != nil){
            MovingThing!.position = CGPointMake(preLocNode.x - MovingThingOffset!.x, preLocNode.y - MovingThingOffset!.y)
        } else {
            if(MovingDirect == MoveDirect.Y){
                for thing in Things{
                    if(thing.Contain(locNode)){
                        MovingThing = thing
                        MovingThingOffset = MovingThing!.convertToNodeSpace(location)
                    }
                }
            }else if (MovingDirect == MoveDirect.X){
                ItemLeftOffset += locNode.x - preLocNode.x
                UpdateItems()
            }
        }
    }
    
    func UpdateAllItemsWidht(){
        AllItemsWidth = ((ItemWidht + ItemIdent) * CGFloat(Things.count)) - ItemIdent
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
        TouchEnd(location)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        if(!Contain(TouchBegan_PointOfTouch!)){
            return
        }
        var allTouches = event.allTouches()?.allObjects
        if(touches.count == 1){
            let touch = touches.anyObject()! as UITouch
            var location:CGPoint = CCDirector.sharedDirector().convertTouchToGL(touch)
            var preLocation:CGPoint = CCDirector.sharedDirector().convertToGL(touch.previousLocationInView(touch.view))
            Move(location, preLocation: preLocation)
        }
    }
    
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
