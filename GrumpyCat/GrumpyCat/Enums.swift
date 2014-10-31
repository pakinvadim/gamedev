//
//  Enums.swift
//  GrumpyCat
//
//  Created by admin on 10.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

enum MoveDirect: Int{
    case X = 0
    case Y = 1
}

enum ActionSpriteState: Int{
    case ActionStateNone = 0
    case ActionStateIdle = 1
    case ActionStateAttack = 2
    case ActionStateWalk = 3
    case ActionStateHurt = 4
    case ActionStateKnockedOut = 5
}

enum BotType: Int{
    case Cat = 0
    case Man = 1
}

enum DoorType: Int{
    case Left = 0
    case Right = 1
    case Top = 2
}

enum TaskStatus:Int{
    case Run = 0
    case Done = 1
    case None = 2
}