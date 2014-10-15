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
    let Indent:CGFloat = 45
    let Doors:[Door] = [Door]()
    var Center: CGPoint{ get{ return ccp(position.x + boundingBox().size.width/2.0, position.y + boundingBox().size.height/2.0)}}
    var MaxLeft:CGFloat{ get{ return position.x + Indent}}
    var MaxRight:CGFloat{ get{ return position.x + boundingBox().size.width - Indent}}
    var FloorPosition:CGFloat{ return position.y + Indent}
    
    init(imageName: String, pos :CGPoint, number:Int){
        Numb = number
        super.init(imageNamed: imageName)
        position = pos
        anchorPoint = ccp(0, 0)
    }
    
    func AddDoorWithType(type:DoorType, dir:Int, positionX:Float) {
        var door = Door(type: type, direct: dir)
        
        if (type == DoorType.Right){
            door.position = ccp(boundingBox().size.width - door.boundingBox().size.width, 0);
        }
        else if (type == DoorType.Left){
            door.position = ccp(0, 0);
        }
        else if (type == DoorType.Top){
            door.position = ccp(positionX, 40);
        }
        Doors.append(door);
        addChild(door, 150)
    }
    
    func GetDoor(direct: Int) -> Door?{
        for door in Doors{
            if(door.Direct == direct){
                return door;
            }
        }
        return nil;
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
