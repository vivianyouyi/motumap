//
//  ViewController.m
//  MAMapKit_2D_Demo
//
//  Created by 翁乐 on 8/9/16.
//  Copyright © 2016 Autonavi. All rights reserved.
//

#import "ViewController.h"
#import "MainPageVC.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIButton *aioButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgColor;
    self.navigationController.navigationBar.hidden = YES;
    //self.extendedLayoutIncludesOpaqueBars = YES;
    //[self createUI];
    [self showScrollView];
}

-(void) showScrollView{
    
    UIScrollView *_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth* 6, kScreenHeight);
    //设置翻页效果，不允许反弹，不显示水平滑动条，设置代理为自己
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    //在UIScrollView 上加入 UIImageView
    for (int i = 0; i < 3; i++) {
        if (i == 0) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"aio_%d.png",i+1]];
            UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i,0,kScreenWidth,kScreenWidth/0.868)];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_scrollView addSubview:imageView];
            
            self.aioButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.aioButton.frame = CGRectMake((kScreenWidth - DYNAMICFITCOUNT(215))/2,imageView.bottom,DYNAMICFITCOUNT(215),35);
            self.aioButton.layer.backgroundColor =Cor3.CGColor;
            self.aioButton.layer.masksToBounds = YES;
            self.aioButton.layer.cornerRadius = 4;
            [self.aioButton setTitle:@"start" forState:UIControlStateNormal];
            [self.aioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.aioButton.titleLabel.font = [UIFont systemFontOfSize:Size4];
            self.aioButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.aioButton  addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:self.aioButton];
            
        }else if (i == 1){
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"aio_%d.png",i+1]];
            UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i,0,kScreenWidth,kScreenWidth/0.864)];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_scrollView addSubview:imageView];
            
        }else if (i == 2){
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"aio_%d.png",i+1]];
            UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * i,0,kScreenWidth,kScreenWidth/0.767)];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [_scrollView addSubview:imageView];
        }
        
    }
    
    //初始化 UIPageControl 和 _scrollView 显示在 同一个页面中
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((kScreenWidth - 50)/2,kScreenHeight - 50, 50, 10)];
    pageControl.numberOfPages = 3;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    pageControl.tag = 201;
    pageControl.pageIndicatorTintColor = TextCor3;
    pageControl.currentPageIndicatorTintColor = Cor1;
    [self.view addSubview: pageControl];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 记录scrollView 的当前位置，因为已经设置了分页效果，所以：位置/屏幕大小 = 第几页
    int current = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    //根据scrollView 的位置对page 的当前页赋值
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    page.currentPage = current;
}
//点击
-(void)startClick:(UIButton*)button{
    NSLog(@"点击start");
    
    //TestViewController *subViewController = [[TestViewController alloc] init];
    MainPageVC *subViewController = [[MainPageVC alloc] init];
    subViewController.title = @"test";
    [self.navigationController pushViewController:subViewController animated:YES];
    
}
-(void)createUI{
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(20,20,100, 50);
    loginButton.layer.borderWidth = 1;
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

