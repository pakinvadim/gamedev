//
//  Room.swift
//  GrumpyCat
//
//  Created by admin on 10.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class Room : RootSprite{
    var Numb: Int = 0
    let Indent:CGFloat = 32
    var Doors:[Door] = [Door]()
    var Things:[ThingBase] = [ThingBase]()
    
    var Center:CGPoint{ get{ return CGPointMake(position.x + boundingBox().size.width/2.0, position.y + boundingBox().size.height/2.0)}}
    var Width:CGFloat = 0
    var Height:CGFloat = 0
    var MaxLeft:CGFloat{ get{ return position.x + Indent}}
    var MaxRight:CGFloat{ get{ return position.x + boundingBox().size.width - Indent}}
    var FloorPosition:CGFloat{ return position.y + Indent}
    
    init(scene:IntroScene, imageName: String, pos :CGPoint, number:Int){
        super.init(scene: scene, imageNamed: imageName)
        Numb = number
        position = pos
        anchorPoint = CGPointMake(0, 0)
        Width = contentSize.width
        Height = contentSize.height
    }
    
    func AddDoor(type:DoorType, dir:Int, positionX:CGFloat) {
        var door = Door(scene: Scene!, type: type, direct: dir)
        door.CurrentRoom = self
        
        if (type == DoorType.Right){
            door.position = CGPointMake(boundingBox().size.width, 0);
        }
        else if (type == DoorType.Left){
            door.position = CGPointZero;
        }
        else if (type == DoorType.Top){
            door.position = CGPointMake(positionX, 200);
        }
        Doors.append(door);
        addChild(door, z: 150)
    }
    
    func GetDoor(direct: Int) -> Door?{
        for door in Doors{
            if(door.Direct == direct){
                return door;
            }
        }
        return nil;
    }
    
    func AddThing(thing:ThingBase, position:CGPoint) {
        thing.position = position
        thing.CurrentRoom = self
        Things.append(thing)
        addChild(thing, z:300)
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
