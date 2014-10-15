//
//  Door.swift
//  GrumpyCat
//
//  Created by admin on 10.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class Door: RootSprite {
    var _currentLevel: GameLevel?
    var _currentRoom: Room?
    
    var Closed: CCActionAnimate
    var Opening: CCActionAnimate
    var AnimationSprite: CCSprite
    let Type: DoorType
    let Direct: Int
    let EnterIndentDoor: Int = 17
    
    var CurrentLevel: GameLevel{
        get{
            if(_currentLevel == nil){
                _currentLevel = CurrentRoom.parent as GameLevel
            }
        return _currentLevel!
        }
    }
    var CurrentRoom: Room{
        get{
            if(_currentRoom == nil){
                _currentRoom = parent as Room
            }
            return _currentRoom!
        }
    }
    var GlobalPosition: CGPoint{
        get{
            return ccpAdd(CurrentRoom.position, position)
        }
    }
    var EnterPosition: CGPoint{
        get{
            var room = CurrentRoom
            if(Type == DoorType.Left){
                return ccp(room.position.x + position.x + contentSize.width/2 + EnterIndentDoor, room.FloorPosition)
            }
            if(Type == DoorType.Left){
                return ccp(room.position.x + position.x + contentSize.width/2 - EnterIndentDoor, room.FloorPosition)
            }
            if(Type == DoorType.Left){
                return ccp(room.position.x + position.x + contentSize.width/2, room.FloorPosition + 30);
            }
            return ccp(0,0);
        }
    }
        
    init(type: DoorType, direct: Int) {
        Type = type
        Direct = direct
        AnimationSprite = CCSprite()
        AnimationSprite.position = ccp(0, 0)
        AnimationSprite.anchorPoint = ccp(0, 0)
        var name: String = ""
        if ( type == DoorType.Left ){ name = "doorLeft"; }
        else if (type == DoorType.Right){ name = "doorRight"; }
        else if ( type == DoorType.Top ){ name = "doorUp"; }
        super.init(imageNamed: "\(name)00.png")
        
        Closed = CCActionAnimate.actionWithAnimation(GetAnimation(name, frameCount: 1, delay: DoorAnimationDelay, wight: 186, hight: 500)) as CCActionAnimate
        Opening = CCActionAnimate.actionWithAnimation(GetAnimation(name, frameRange: [1, 2, 3, 3, 2, 1], delay: DoorAnimationDelay, wight: 186, hight: 500)) as CCActionAnimate
        anchorPoint = ccp(0,0)
        
        addChild(AnimationSprite)
    }
    
    override init(texture : CCTexture!, rect: CGRect){ super.init(texture: texture, rect: rect) }
    override init(texture: CCTexture!, rect: CGRect, rotated: Bool) { super.init(texture: texture, rect: rect, rotated: rotated) }
    override init(imageNamed imageName: String!) {super.init(imageNamed: imageName)}
    override init(spriteFrame: CCSpriteFrame!) {super.init(spriteFrame: spriteFrame)}
}
