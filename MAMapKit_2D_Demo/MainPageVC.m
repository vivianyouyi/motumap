//
//  AddControlsViewController.m
//  MAMapKit_2D_Demo
//
//  Created by shaobin on 16/8/16.
//  Copyright © 2016年 Autonavi. All rights reserved.
//

#import "MainPageVC.h"
#import "SearchVC.h"
#import "DistrictViewController.h"

@interface MainPageVC ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UIView *searchBgView;
@property(nonatomic,strong)UIImageView *avatarImageView;

@property(nonatomic,strong)UIImageView *lineLeft;
@property(nonatomic,strong)UIImageView *searchIcon;
@property(nonatomic,strong)UILabel *searchLabel;
@property(nonatomic,strong)UIImageView *lineRight;
@property(nonatomic,strong)UIImageView *voiceImageView;

@property (nonatomic, strong) UIButton *gpsButton;

@end

@implementation MainPageVC
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(returnAction)];
    
    self.navigationController.navigationBar.hidden = YES;
   
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(39.907728, 116.397968);
    self.mapView.showsUserLocation = YES;
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
    
     [self createSearchView];
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
    subViewController.title = @"test";
    [self.navigationController pushViewController:subViewController animated:YES];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
