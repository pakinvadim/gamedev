//
//  GameLevelInitHelper.swift
//  GrumpyCat
//
//  Created by admin on 15.12.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class GameLevelInitHelper {
    class func AddRooms(l:GameLevel){
        let wallConst:CGFloat = 45
        let floorConst:CGFloat = 39
        
        l.Room9 = Room(scene: l.Scene!, imageName: "R0.png", pos: CGPointMake(0, 0-512-floorConst), number: 9)
        l.Room9!.AddWall(WallType.Right)
        l.Room9!.AddWall(WallType.Left)
        l.Room9!.AddDoor(DoorType.Top, dir:11, positionX:400)
        
        l.Room10 = Room(scene: l.Scene!, imageName: "R10.png", pos: CGPointMake(0-1024-wallConst, 0), number: 10)
        l.Room10!.AddDoor(DoorType.Right, dir:11, positionX:0)
        
        l.Room11 = Room(scene: l.Scene!, imageName: "R11.png", pos: CGPointMake(0, 0), number: 11)
        l.Room11!.AddWall(WallType.Left)
        l.Room11!.AddDoor(DoorType.Left, dir:10, positionX:0)
        l.Room11!.AddDoor(DoorType.Right, dir:12, positionX:0)
        l.Room11!.AddDoor(DoorType.Top, dir:9, positionX:400)
        
        l.Room12 = Room(scene: l.Scene!, imageName: "R12.png", pos: CGPointMake(768 + wallConst, 0), number: 12)
        l.Room12!.AddWall(WallType.Right)
        l.Room12!.AddWall(WallType.Left)
        //l.Room12!.AddDoor(DoorType.Left, dir:11, positionX:0)
        //l.Room12!.AddDoor(DoorType.Right, dir:13, positionX:0)
        l.Room12!.AddDoor(DoorType.Top, dir:22, positionX:1536-400)
        
        l.Room13 = Room(scene: l.Scene!, imageName: "R13.png", pos:CGPointMake(768 + 1536 + 2*wallConst, 0), number:13)
        l.Room13!.AddDoor(DoorType.Left, dir:12, positionX:0)
        l.Room13!.AddDoor(DoorType.Right, dir:14, positionX:0)
        l.Room13!.AddDoor(DoorType.Top, dir:23, positionX:1024-400)
        
        l.Room14 = Room(scene: l.Scene!, imageName: "R14.png", pos:CGPointMake(768 + 1536 + 1024 + 3*wallConst, 0), number:14)
        l.Room14!.AddWall(WallType.Right)
        l.Room14!.AddWall(WallType.Left)
        l.Room14!.AddDoor(DoorType.Left, dir:13, positionX:0)
        
        l.Room21 = Room(scene: l.Scene!, imageName: "R21.png", pos:CGPointMake(-256, 512 + floorConst), number:21)
        l.Room21!.AddDoor(DoorType.Right, dir:22, positionX:0)
        
        l.Room22 = Room(scene: l.Scene!, imageName: "R22.png", pos:CGPointMake(768 + wallConst, 512 + floorConst), number:22)
        l.Room22!.AddWall(WallType.Right)
        l.Room22!.AddWall(WallType.Left)
        l.Room22!.AddDoor(DoorType.Left, dir:21, positionX:0)
        l.Room22!.AddDoor(DoorType.Right, dir:23, positionX:0)
        l.Room22!.AddDoor(DoorType.Top, dir:31, positionX:400)
        l.Room22!.AddDoor(DoorType.Top, dir:12, positionX:1536-400)
        
        l.Room23 = Room(scene: l.Scene!, imageName: "R23.png", pos:CGPointMake(768 + 1536 + 2*wallConst, 512 + floorConst), number:23)
        l.Room23!.AddDoor(DoorType.Left, dir:22, positionX:0)
        l.Room23!.AddDoor(DoorType.Right, dir:24, positionX:0)
        l.Room23!.AddDoor(DoorType.Top, dir:13, positionX:1024-400)
        
        l.Room24 = Room(scene: l.Scene!, imageName: "R24.png", pos:CGPointMake(768 + 1536 + 1024 + 3*wallConst, 512 + floorConst), number:24)
        l.Room24!.AddWall(WallType.Right)
        l.Room24!.AddWall(WallType.Left)
        l.Room24!.AddDoor(DoorType.Left, dir:23, positionX:0)
        
        l.Room31 = Room(scene: l.Scene!, imageName: "R31.png", pos:CGPointMake(768 + wallConst, 2*(512 + floorConst)), number:31)
        l.Room31!.AddWall(WallType.Right)
        l.Room31!.AddWall(WallType.Left)
        l.Room31!.AddDoor(DoorType.Top, dir:22, positionX:400)
        
        l.AddRoom(l.Room9!)
        l.AddRoom(l.Room10!)
        l.AddRoom(l.Room11!)
        l.AddRoom(l.Room12!)
        l.AddRoom(l.Room13!)
        l.AddRoom(l.Room14!)
        l.AddRoom(l.Room21!)
        l.AddRoom(l.Room22!)
        l.AddRoom(l.Room23!)
        l.AddRoom(l.Room24!)
        l.AddRoom(l.Room31!)
    }
    
    class func AddFloor(level: GameLevel) {
        let blockWidth:CGFloat = 226
        let blockHight:CGFloat = 39
        let FloorInfos:[(Width:CGFloat, FloorX:CGFloat, FloorY:CGFloat)] = [
            (1536 + 2*45, 768, 2*512+blockHight),
            (4608 + 4*45, -256, 512),
            (4352 + 5*45, -45, 0-blockHight),
            (1536 + 2*45, -45, 0-2*blockHight-512)
        ]
        
        for info in FloorInfos {
            let blocks:Int = Int(floor(info.Width / blockWidth))
            var i:CGFloat = info.FloorX
            let iEnd = info.FloorX + info.Width
            while i <= iEnd - blockWidth {
                var block:CCSprite = CCSprite(imageNamed: "WW.png")
                block.anchorPoint = CGPointZero
                block.position = CGPointMake(i, info.FloorY)
                level.addChild(block, z: 11)
                i += blockWidth
                if(i > iEnd - blockWidth && i != iEnd){
                    i = iEnd - blockWidth
                }
            }
        }
    }
    
    class func AddTree(level: GameLevel){
        let tree = Tree(scene: level.Scene!)
        tree.position = CGPointMake(0-1024-45, 0)
        level.addChild(tree, z: 3)
    }
    
    class func AddGround(level: GameLevel){
        let ground = CCNodeColor(color: CCColor(red: 0.48, green: 0.4, blue: 0.3), width: 6000, height: 512+39+200)
        ground.anchorPoint = CGPointZero
        ground.position = CGPointMake(-1024-45-200, -512-39-200)
        level.addChild(ground, z: 1);
    }
}
