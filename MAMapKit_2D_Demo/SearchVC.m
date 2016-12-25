//
//  SearchVC.m
//  MotuMap
//
//  Created by 李维维 on 2016/12/24.
//  Copyright © 2016年 Autonavi. All rights reserved.
//
//

#import "SearchVC.h"
#import "CommonUtility.h"
#import "AMapTipAnnotation.h"
#import "BusStopAnnotation.h"
#import "POIAnnotation.h"
#import "BusStopDetailViewController.h"
#import "PoiDetailViewController.h"
#import "TipDetailViewController.h"

#define TipPlaceHolder @"名称"
#define BusLinePaddingEdge 20

@interface SearchVC ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>
{
    UITextView *ideaField;
    
}

//@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;



@property (nonatomic, strong) UIView *searchBgView;


/**左边按钮*/
@property (nonatomic,retain)UIButton *leftBtn;
/**右边按钮*/
@property (nonatomic,retain)UIButton *rightBtn;
@property(nonatomic,strong)UIButton *voiceBtn;

@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, strong) NSMutableArray *busLines;

@end

@implementation SearchVC
@synthesize tips = _tips;

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.tips = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES ;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.view.backgroundColor = Cor1;
    
    [self initSearchView];
}

#pragma mark - Initialization

- (void)initSearchView
{
    
    self.searchBgView = [[UIView alloc]initWithFrame:CGRectMake(0,20, kScreenWidth,50)];
    self.searchBgView.backgroundColor = Cor4;
    [self.view addSubview:self.searchBgView];
    
    //左边按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    _leftBtn.frame = CGRectMake(0, 0, 40, 50);
    [_leftBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [self.searchBgView addSubview:_leftBtn];
    
    UIView *innerBgView = [[UIView alloc]initWithFrame:CGRectMake(40,8, kScreenWidth - 60,34)];
    innerBgView.backgroundColor = Cor1;
    [self.searchBgView addSubview:innerBgView];
    
    UIImageView *searchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7,20, 20)];
    searchIcon.image = [UIImage imageNamed:@"avatar"];
    [innerBgView addSubview:searchIcon];
  
   
    ideaField = [[UITextView alloc] initWithFrame:CGRectMake(30,0,innerBgView.width - 45,34)];
    ideaField.backgroundColor = Cor1;
    ideaField.font =  [UIFont systemFontOfSize:Size3];
    ideaField.returnKeyType = UIReturnKeyDefault;
    ideaField.contentMode = UIViewContentModeCenter;
    ideaField.textColor = Cor4;
    ideaField.text = @"搜索";
    ideaField.delegate = self;
    ideaField.layoutManager.allowsNonContiguousLayout = NO;
    [innerBgView addSubview:ideaField];
    
    self.voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.voiceBtn.frame = CGRectMake(innerBgView.width - 25, 7,20, 20);
    [innerBgView addSubview:self.voiceBtn];
    UIImage *addImage = [UIImage imageNamed:@"avatar"];
    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,20, 20)];
    addImageView.image = addImage;
    [self.voiceBtn addSubview:addImageView];
    [self.voiceBtn addTarget:self action:@selector(startVoiceSearch) forControlEvents:UIControlEventTouchUpInside];
  
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([ideaField.text isEqualToString:@"搜索"]) {
        textView.text=@"";
        textView.textColor = Cor2;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(ideaField.text.length > 0&&![ideaField.text isEqualToString:@"搜索"])
    {
        [self searchTipsWithKey:ideaField.text];
        return;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (ideaField == textView) {
        if (text.length == 0) return YES;
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 200) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - action handling
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Utility

/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city     = @"北京";
    //    tips.cityLimit = YES; 是否限制城市
    
    [self.search AMapInputTipsSearch:tips];
}

- (void)gotoDetailForTip:(AMapTip *)tip
{
    if (tip != nil)
    {
        TipDetailViewController *tipDetailViewController = [[TipDetailViewController alloc] init];
        tipDetailViewController.tip                      = tip;
        
        [self.navigationController pushViewController:tipDetailViewController animated:YES];
    }
}

- (void)gotoDetailForBusStop:(AMapBusStop *)busStop
{
    if (busStop != nil)
    {
        BusStopDetailViewController *busStopDetailViewController = [[BusStopDetailViewController alloc] init];
        busStopDetailViewController.busStop                      = busStop;
        
        [self.navigationController pushViewController:busStopDetailViewController animated:YES];
    }
}

- (void)gotoDetailForPoi:(AMapPOI *)poi
{
    if (poi != nil)
    {
        PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
        detail.poi                      = poi;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.tips setArray:response.tips];
    
    NSLog(@"onInputTipsSearchDone: %lu", self.tips.count);
    
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
        cell.imageView.image = [UIImage imageNamed:@"locate"];
    }
    
    AMapTip *tip = self.tips[indexPath.row];
    
    if (tip.location == nil)
    {
        cell.imageView.image = [UIImage imageNamed:@"search"];
    }
    
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.address;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *tip = self.tips[indexPath.row];
    
}

@end

