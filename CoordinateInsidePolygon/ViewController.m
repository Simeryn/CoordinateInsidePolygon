//
//  ViewController.m
//  CoordinateInsidePolygon
//
//  Created by Simeryn on 5/24/18.
//  Copyright © 2018 Simeryn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray* arrLocations = [[NSMutableArray alloc]init];
    CLLocation* locPoly = [[CLLocation alloc] initWithLatitude:13.12713978995039 longitude:77.44924661475247];
    [arrLocations addObject:locPoly];
    locPoly = [[CLLocation alloc] initWithLatitude:12.81919030351148 longitude:77.44403925566547];
    [arrLocations addObject:locPoly];
    locPoly = [[CLLocation alloc] initWithLatitude:12.82421177497613 longitude:77.86039370029307];
    [arrLocations addObject:locPoly];
    locPoly = [[CLLocation alloc] initWithLatitude:12.98951340621052 longitude:77.89102302690982];
    [arrLocations addObject:locPoly];
    locPoly = [[CLLocation alloc] initWithLatitude:13.17623239364219 longitude:77.7288900698951];
    [arrLocations addObject:locPoly];
    locPoly = [[CLLocation alloc] initWithLatitude:13.12713978995039 longitude:77.44924661475247];
    [arrLocations addObject:locPoly];
    CLLocation* currenLocation = [[CLLocation alloc] initWithLatitude:13.06202387290584 longitude:77.52374844115451];
    BOOL contain = [CoordinateInsidePolygonFile containsLocation:currenLocation polygon:arrLocations presentOrNot:YES];
    NSLog(@"%d",contain);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
