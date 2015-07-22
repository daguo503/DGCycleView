//
//  DGCycleView.m
//  CycleScrollView
//
//  Created by Mac on 15/7/21.
//  Copyright (c) 2015年 issuser. All rights reserved.
//

#import "DGCycleView.h"

#define timeIntervals 5.0

@interface DGCycleView ()<UIScrollViewDelegate>
{
    
}

@property (nonatomic,strong) UIScrollView  *contentScrollView;
@property (nonatomic,strong) UIImageView   *currentImageView;
@property (nonatomic,strong) UIImageView   *lastImageView;
@property (nonatomic,strong) UIImageView   *nextImageView;
@property (nonatomic,strong) UIPageControl *pageIndicator;
@property (nonatomic,strong) NSTimer       *timer;
@property (nonatomic,strong) NSArray       *imageArray;
@property (nonatomic,assign) NSInteger     currentImageIndex;
@property (nonatomic,assign) id<DGCycleViewDelegate>delegate;
//@property (nonatomic,assign) NSInteger     timeInterval;

@end

@implementation DGCycleView
@synthesize contentScrollView = _contentScrollView;
@synthesize currentImageView = _currentImageView;


-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = imageArray;
        _currentImageIndex = 0;
        [self configDGCycleScrollView];
        
    }
    return self;
}


-(void)configDGCycleScrollView
{   //初始化滚动视图
    _contentScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_contentScrollView setContentSize:CGSizeMake(self.frame.size.width*3, 0)];
    _contentScrollView.delegate = self;
    _contentScrollView.bounces = false;
    _contentScrollView.pagingEnabled = true;
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.showsHorizontalScrollIndicator = false;
    _contentScrollView.scrollEnabled = !(_imageArray.count<=1);
    [self addSubview:_contentScrollView];
    //初始化当前显示视图
    _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _currentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _currentImageView.userInteractionEnabled  = true;
    _currentImageView.clipsToBounds = true;
    [_contentScrollView addSubview:_currentImageView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapped:)];
    [_currentImageView addGestureRecognizer:tapGes];
    
    //初始化上一张视图
    _lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _lastImageView.clipsToBounds = true;
    _lastImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_contentScrollView addSubview:_lastImageView];
    //初始化下一张视图
    _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    _nextImageView.contentMode = UIViewContentModeScaleAspectFill;
    _nextImageView.clipsToBounds = true;
    [_contentScrollView addSubview:_nextImageView];
    
    [self setImagesOnScrollView];
    [_contentScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:false];
    
    //初始化页面指示器
    _pageIndicator = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width-20*_imageArray.count, self.frame.size.height-30, 20*_imageArray.count, 20)];
//    _pageIndicator.currentPage = _currentImageIndex;
    _pageIndicator.hidesForSinglePage = true;
    _pageIndicator.numberOfPages = _imageArray.count;
    _pageIndicator.backgroundColor = [UIColor clearColor];
//    [_pageIndicator  addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageIndicator];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeIntervals target:self selector:@selector(timeAction) userInfo:nil repeats:true];
    
}


-(void)setImagesOnScrollView
{
    _currentImageView.image = [_imageArray objectAtIndex:_currentImageIndex];
    _nextImageView.image = [_imageArray objectAtIndex:[self getNextImageIndex:_currentImageIndex]];
    _lastImageView.image = [_imageArray objectAtIndex:[self getLastImageIndex:_currentImageIndex]];
    
}

-(NSInteger)getLastImageIndex:(NSInteger)currentIndex
{
    NSInteger tempIndex = currentIndex - 1;
    if (tempIndex == -1) {
        return _imageArray.count-1;
    }else{
        return tempIndex;
    }
}

-(NSInteger)getNextImageIndex:(NSInteger)currentIndex
{
    NSInteger tempIndex = currentIndex + 1;
    return tempIndex < _imageArray.count ? tempIndex : 0;
}


-(void)imageTapped:(UITapGestureRecognizer *)tapGestureRecongnizer
{
//    NSLog(@"clicked   %d ",_currentImageIndex);
    if ([_delegate respondsToSelector:@selector(cycleView:clickIndex:)]) {
        [_delegate cycleView:self clickIndex:_currentImageIndex];
    }
}



-(void)timeAction
{
    [_contentScrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:true];
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//}


#pragma mark UIScrollViewDelegate Methods
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    if (offset == 0) {
        _currentImageIndex = [self getLastImageIndex:_currentImageIndex];
    }else if (offset == self.frame.size.width*2)
    {
        _currentImageIndex = [self getNextImageIndex:_currentImageIndex];
    }
    [self setImagesOnScrollView];
    [_contentScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:false];
    [_pageIndicator setCurrentPage:_currentImageIndex];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:_contentScrollView];
}






@end
