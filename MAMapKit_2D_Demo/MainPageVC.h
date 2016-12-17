//
//  MainPageVC.h
//  MotuMap
//
//  Created by 李维维 on 2016/12/17.
//  Copyright © 2016年 Autonavi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface MainPageVC : UIViewController

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@end
