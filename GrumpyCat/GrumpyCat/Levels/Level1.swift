//
//  Level1.swift
//  GrumpyCat
//
//  Created by CoonStudio on 05.10.14.
//  Copyright (c) CoonStudio. All rights reserved.
//

import Foundation

class Level1 : GameLevel {    
    override init(scene:IntroScene) {
        super.init(scene: scene)
    }
    
    override func InitAll(){
        super.InitAll()
        Cat!.BindToRoom(21)
        Man!.BindToRoom(12)
        //Man!.position = CGPointMake(0, 0)
        let otvertka = Otvertka(scene: Scene!)
        let televizor = Televizor(scene: Scene!)
        let televizor2 = Televizor2(scene: Scene!)
        /*Room2!.AddThing(otvertka, position: CGPointMake(1060, 265))
        Room1!.AddThing(televizor, position: CGPointMake(800, 150))
        Room4!.AddThing(televizor2, position: CGPointMake(600, 150))*/
        
        Man!.PermanentLogics.append(GoToCenterRoomLogic(room: Room10!))
        Man!.PermanentLogics.append(GoToCenterRoomLogic(room: Room9!))
        Man!.PermanentLogics.append(GoToCenterRoomLogic(room: Room14!))
        Man!.PermanentLogics.append(GoToCenterRoomLogic(room: Room21!))
        Man!.PermanentLogics.append(GoToCenterRoomLogic(room: Room24!))
        Man!.PermanentLogics.append(GoToCenterRoomLogic(room: Room31!))
        //Man!.PermanentLogics.append(GoToRoomObjectLogic(object: televizor2))
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}