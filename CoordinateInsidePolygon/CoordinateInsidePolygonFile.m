//
//  CoordinateInsidePolygonFile.m
//  CoordinateInsidePolygon
//
//  Created by Simeryn on 5/24/18.
//  Copyright © 2018 Simeryn. All rights reserved.
//

#import "CoordinateInsidePolygonFile.h"

@implementation CoordinateInsidePolygonFile


+ (double)degreeToRadians :(double)paramDegree {
    return paramDegree * M_PI/180;
}
+ (BOOL)containsLocation :(CLLocation*)point polygon:(NSMutableArray*)polygon presentOrNot:(BOOL)presentOrNot {
    // polygon : array of CLLocation
    return [self containsLocation:point.coordinate.latitude longitude:point.coordinate.longitude polygon:polygon geodesic:presentOrNot];
}

+ (BOOL)containsLocation :(double)latitude longitude:(double)longitude polygon:(NSMutableArray*)polygon geodesic:(BOOL)geodesic {
    const NSUInteger size = polygon.count;
    if (size == 0) {
        return false;
    }
    double lat3 = [self degreeToRadians:latitude];
    double lng3 = [self degreeToRadians:longitude];
    CLLocation* prev = [polygon objectAtIndex:(size -1)];
    double lat1 = [self degreeToRadians:prev.coordinate.latitude];
    double lng1 = [self degreeToRadians:prev.coordinate.longitude];
    
    int nIntersect = 0;
    for (CLLocation* point2 in polygon) {
        double dLng3 =[self wrap:(lng3 - lng1) min:-3.141592653589793 max:3.141592653589793];
        // Special case: point equal to vertex is inside.
        if (lat3 == lat1 && dLng3 == 0) {
            return true;
        }
        double lat2 = [self degreeToRadians:point2.coordinate.latitude];
        double lng2 = [self degreeToRadians:point2.coordinate.longitude];
        // Offset longitudes by -lng1.
        if ([self intersects:lat1 lat2:lat2 lng2:[self wrap:(lng2 - lng1) min:-3.141592653589793 max:3.141592653589793] lat3:lat3 lng3:dLng3 geodesic:geodesic]) {
            ++nIntersect;
        }
        lat1 = lat2;
        lng1 = lng2;
    }
    return (nIntersect & 1) != 0;
}
+ (double)wrap :(double)n min:(double)min max:(double)max {
    return n >= min && n < max ? n :  fmod(n - min, max - min) + min;
}
+ (BOOL)intersects :(double)lat1 lat2:(double)lat2 lng2:(double)lng2 lat3:(double)lat3 lng3:(double)lng3 geodesic:(BOOL)geodesic {
    if ((lng3 < 0.0 || lng3 < lng2) && (lng3 >= 0.0 || lng3 >= lng2)) {
        if (lat3 <= -1.5707963267948966) {
            return false;
        } else if (lat1 > -1.5707963267948966 && lat2 > -1.5707963267948966 && lat1 < 1.5707963267948966 && lat2 < 1.5707963267948966) {
            if (lng2 <= -3.141592653589793) {
                return false;
            } else {
                double linearLat = (lat1 * (lng2 - lng3) + lat2 * lng3) / lng2;
                if (lat1 >= 0.0 && lat2 >= 0.0 && lat3 < linearLat) {
                    return false;
                } else if (lat1 <= 0.0 && lat2 <= 0.0 && lat3 >= linearLat) {
                    return true;
                } else if (lat3 >= 1.5707963267948966) {
                    return true;
                } else {
                    return geodesic ? tan(lat3) >= [self tanLatGC:lat1 lat2:lat2 lng2:lng2 lng3:lng3] : [self mercator:lat3] >= [self mercatorLatRhumb:lat1 lat2:lat2 lng2:lng2 lng3:lng3];
                }
            }
        } else {
            return false;
        }
    } else {
        return false;
    }
}
+ (double)tanLatGC :(double)lat1 lat2:(double)lat2 lng2:(double)lng2 lng3:(double)lng3 {
    return (tan(lat1) * sin(lng2 - lng3) + tan(lat2) * sin(lng3)) / sin(lng2);
}
+ (double)mercator :(double)lat {
    return log(tan(lat * 0.5 + 0.7853981633974483));
}
+ (double)mercatorLatRhumb :(double)lat1 lat2:(double)lat2 lng2:(double)lng2 lng3:(double)lng3 {
    return ([self mercator:lat1] * (lng2 - lng3) + [self mercator:(lat2)]* lng3) / lng2;
}
@end
