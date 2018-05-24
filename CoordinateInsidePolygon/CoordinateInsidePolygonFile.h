//
//  CoordinateInsidePolygonFile.h
//  CoordinateInsidePolygon
//
//  Created by Simeryn on 5/24/18.
//  Copyright © 2018 Simeryn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <math.h>

@interface CoordinateInsidePolygonFile : NSObject

+ (double)degreeToRadians :(double)paramDegree;
+ (BOOL)containsLocation :(CLLocation*)point polygon:(NSMutableArray*)polygon presentOrNot:(BOOL)presentOrNot;
+ (BOOL)containsLocation :(double)latitude longitude:(double)longitude polygon:(NSMutableArray*)polygon geodesic:(BOOL)geodesic;
+ (double)wrap :(double)n min:(double)min max:(double)max;
+ (BOOL)intersects :(double)lat1 lat2:(double)lat2 lng2:(double)lng2 lat3:(double)lat3 lng3:(double)lng3 geodesic:(BOOL)geodesic;
+ (double)tanLatGC :(double)lat1 lat2:(double)lat2 lng2:(double)lng2 lng3:(double)lng3;
+ (double)mercator :(double)lat;
+ (double)mercatorLatRhumb :(double)lat1 lat2:(double)lat2 lng2:(double)lng2 lng3:(double)lng3;

@end
