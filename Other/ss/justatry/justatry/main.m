//
//  main.m
//  justatry
//
//  Created by Pakinvadim on 03.11.13.
//  Copyright (c) 2013 Pakinvadim. All rights reserved.
//

#import <Foundation/Foundation.h>

float circleArea(float theRadius); // [44.4]
float rectangleArea(float width, float height); // [44.5]

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        int pictureWidth;
        float pictureHeight, pictureSurfaceArea,
        circleRadius, circleSurfaceArea;
        
        pictureWidth = 8;
        pictureHeight = 4.5;
        circleRadius = 5.0;
        
        pictureSurfaceArea = pictureWidth * pictureHeight;
        circleSurfaceArea = circleArea(circleRadius);
        
        NSLog(@"Площадь картинки: %f. Площадь окружности: %10.2f.",
              pictureSurfaceArea, circleSurfaceArea);
        
    }
    return 0;
}
float circleArea(float theRadius) // [44.24]
{
    float theArea;
    theArea = 3.14159 * theRadius * theRadius;
    return theArea;
}
float rectangleArea(float width, float height) // [44.31]
{
    return width *height;
}

