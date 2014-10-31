//
//  Level1.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) CoonStudio. All rights reserved.
//

import Foundation

class Level1 : GameLevel {
    let wallConst:CGFloat = 25.0
    let floorConst:CGFloat = 25.0
    
    override init(scene:IntroScene) {
        super.init(scene: scene)
        
        var room1:Room = Room(scene: scene, imageName: "room1.png", pos: CGPointMake(0, 0), number: 1)
        room1.AddDoor(DoorType.Left, dir: 2, positionX: 0)
        room1.AddDoor(DoorType.Top, dir:4, positionX:400)
        AddRoom(room1)
        
        var room2:Room = Room(scene: scene, imageName: "room1.png", pos: CGPointMake(-1600 - wallConst, 0), number: 2)
        room2.AddDoor(DoorType.Right, dir:1, positionX:0)
        room2.AddDoor(DoorType.Top, dir:3, positionX:100)
        AddRoom(room2)
        
        var room3:Room = Room(scene: scene, imageName: "room1.png", pos:CGPointMake(-1600 - wallConst, 640 + floorConst), number:3)
        room3.AddDoor(DoorType.Right,  dir:4, positionX:0)
        room3.AddDoor(DoorType.Top, dir:2, positionX:100)
        AddRoom(room3)
        
        var room4:Room = Room(scene: scene, imageName: "room1.png", pos:CGPointMake(0, 640 + floorConst), number:4)
        room4.AddDoor(DoorType.Top, dir:1, positionX:400)
        room4.AddDoor(DoorType.Left, dir:3, positionX:0)
        room4.AddDoor(DoorType.Top, dir:5, positionX:200)
        
        AddRoom(room4)
        
        var room5:Room = Room(scene: scene, imageName: "room1.png", pos:CGPointMake(0, 2 * (640 + floorConst)), number:5)
        room5.AddDoor(DoorType.Top, dir:4, positionX:200)
        AddRoom(room5)
        
        
        //self.cat.position = ccp(120,520);
        
        Cat!.BindToRoom(1)
        
        room2.AddThing(Otvertka(scene: scene), position: CGPointMake(1060, 265))
        room3.AddThing(Televizor(scene: scene), position: CGPointMake(300, 265))
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}