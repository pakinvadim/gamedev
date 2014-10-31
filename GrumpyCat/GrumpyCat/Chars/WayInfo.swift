//
//  WayInfo.swift
//  GrumpyCat
//
//  Created by admin on 19.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

class WayInfo {
    var EndPoint:CGPoint?
    var Way:[Int] = [Int]()
    var Ways:[[Int]] = [[Int]]()
    var CheckedRooms:[Int] = [Int]()
    var Empty:Bool{get{return Ways.count == 0 && (EndPoint == nil || (EndPoint!.x == 0 && EndPoint!.y == 0))}}
    
    init(){}
    
    func Populate() {
        if(Ways.count == 0){
            return
        }
        
        Way = Ways.first!
        for wayItem:[Int] in Ways{
            if(Way.count > wayItem.count){
                Way = wayItem;
            }
        }
    }
    
    class func GetWay(scene:IntroScene, startRoom:Room, endRoom:Room, endPoint:CGPoint) -> WayInfo{
        var wayInfo:WayInfo = WayInfo()
        if (endRoom.Numb != startRoom.Numb) // проверяем не нажали ли туже комнату
        {
            var tempWay:[Int] = [startRoom.Numb]
            GetWalkRouteTo(scene, endRoom: endRoom, startRoom: startRoom, wayInfo: &wayInfo, tempWay: &tempWay)
            wayInfo.Populate()
        }
        wayInfo.EndPoint = endPoint
        return wayInfo;
    }
    
    class func GetWalkRouteTo(scene:IntroScene, endRoom:Room, startRoom:Room, inout wayInfo:WayInfo, inout tempWay:[Int]){
        /*NSArray *sortedRooms = [actualRoom.doors sortedArrayUsingComparator:^(Door* door1, Door* door2) {
        float door1Distance = [self DistanceBetween:door1 and:endRoom];
        float door2Distance = [self DistanceBetween:door2 and:endRoom];
        
        if (door1Distance < door2Distance) {
        return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (door1Distance > door2Distance) {
        return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
        }];*/
        
        for door:Door in startRoom.Doors {
            var dir:Int = door.Direct
            tempWay.append(dir);
            if(dir == endRoom.Numb){
                wayInfo.Ways.append(tempWay)
            }
            else{
                if(!contains(wayInfo.CheckedRooms, dir)){
                    wayInfo.CheckedRooms.append(startRoom.Numb)
                    GetWalkRouteTo(scene, endRoom: endRoom, startRoom: scene.ActualLevel!.GetRoom(dir)!, wayInfo: &wayInfo, tempWay: &tempWay)
                    
                    /*if([(NSNumber*)[routeNumRoom firstObject] integerValue] == endRoom.numberRoom)
                    {
                    [routeNumRoom addObject:[NSNumber numberWithInteger:dir]];
                    return routeNumRoom;
                    }*/
                }
            }
            tempWay.removeLast()
            //}
        }
    }
}