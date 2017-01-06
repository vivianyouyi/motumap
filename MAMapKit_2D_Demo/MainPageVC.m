//
//  AddControlsViewController.m
//  MAMapKit_2D_Demo
//
//  Created by shaobin on 16/8/16.
//  Copyright © 2016年 Autonavi. All rights reserved.
//

#import "MainPageVC.h"
#import "SearchVC.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface MainPageVC ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UIView *searchBgView;
@property(nonatomic,strong)UIImageView *avatarImageView;

@property(nonatomic,strong)UIImageView *lineLeft;
@property(nonatomic,strong)UIImageView *searchIcon;
@property(nonatomic,strong)UILabel *searchLabel;
@property(nonatomic,strong)UIImageView *lineRight;
@property(nonatomic,strong)UIImageView *voiceImageView;

@property (nonatomic, strong) UIButton *gpsButton;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@end

@implementation MainPageVC
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self initMapView];
    [self createSearchView];
    [self configLocationManager];
}
#pragma mark - Action Handle

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        NSLog(@"location.coordinate.latitude:%f", location.coordinate.latitude);
        NSLog(@"location.coordinate.longitude:%f", location.coordinate.longitude);
    
        self.city = regeocode.city;
        NSLog(@"self.city :%@", self.city );
        //获取到定位信息，更新annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        [self addAnnotationToMapView:annotation];
    }];
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    NSLog(@"addAnnotationToMapView:");
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)initMapView
{
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(39.907728, 116.397968);
    self.mapView.showsUserLocation = YES;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    [self.view addSubview:self.mapView];
    
    UIView *zoomPannelView = [self makeZoomPannelView];
    zoomPannelView.center = CGPointMake(self.view.bounds.size.width -  CGRectGetMidX(zoomPannelView.bounds) - 10,
                                        self.view.bounds.size.height -  CGRectGetMidY(zoomPannelView.bounds) - 10);
    
    zoomPannelView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:zoomPannelView];
    
    self.gpsButton = [self makeGPSButtonView];
    self.gpsButton.center = CGPointMake(CGRectGetMidX(self.gpsButton.bounds) + 10,
                                        self.view.bounds.size.height -  CGRectGetMidY(self.gpsButton.bounds) - 20);
    [self.view addSubview:self.gpsButton];
    self.gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    
}
-(void) createSearchView{
    self.searchBgView = [[UIView alloc]initWithFrame:CGRectMake(14,30, kScreenWidth-28,60)];
    self.searchBgView.backgroundColor = Cor1;
    [self.view addSubview:self.searchBgView];

    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10,40, 40)];
    _avatarImageView.image = [UIImage imageNamed:@"avatar"];
    [self.searchBgView addSubview:_avatarImageView];
    
    _searchLabel = [UILabel labelWithFrame:CGRectMake(_avatarImageView.right + 10,23,DYNAMICFITCOUNT(380),Size3+DYNAMICFITCOUNT(4)) font:Size3 backgroundColor:[UIColor clearColor] textColor:Cor4];
    _searchLabel.text = @"查找地点，避开限行区域";
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startToSearch:)];
    [_searchLabel addGestureRecognizer:labelTapGestureRecognizer];
    _searchLabel.userInteractionEnabled=YES;
    
    [self.searchBgView addSubview:_searchLabel];
 
    
    _voiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_searchBgView.right-60, 10,40, 40)];
    _voiceImageView.image = [UIImage imageNamed:@"avatar"];
    [self.searchBgView addSubview:_voiceImageView];
    
}

-(void) startToSearch:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    
    NSLog(@"%@被点击了",label.text);
    
    //DistrictViewController *subViewController = [[DistrictViewController alloc] init];
    
    SearchVC *subViewController = [[SearchVC alloc] init];
    subViewController.city = self.city;
    subViewController.title = @"test";
    [self.navigationController pushViewController:subViewController animated:YES];
    
    
}

- (UIButton *)makeGPSButtonView {
    UIButton *ret = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ret.backgroundColor = [UIColor whiteColor];
    ret.layer.cornerRadius = 4;
    
    [ret setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return ret;
}

- (UIView *)makeZoomPannelView
{
    UIView *ret = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 98)];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    
    return ret;
}

#pragma mark - Action Handlers
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zoomPlusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}

- (void)gpsAction {
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsButton setSelected:YES];
    }
}
@end
