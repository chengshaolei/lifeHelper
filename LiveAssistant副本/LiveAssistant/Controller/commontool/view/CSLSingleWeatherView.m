//
//  HQSingleWeatherView.m
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import "CSLSingleWeatherView.h"
#import "CSLWeatherModel.h"
#import "CSLWeatherDAL.h"
#import "CSLCollectionViewCell.h"
#define cellIndentifier @"bounds"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kheight [UIScreen mainScreen].bounds.size.height
#define kNavi 64
#define kNewHeight [UIScreen mainScreen].bounds.size.height-64

@implementation CSLSingleWeatherView {
    NSMutableArray * _array;
}

- (id)initWithFrame:(CGRect)frame withCity:(CSLWeatherModel *)city {
    if (self = [self initWithFrame:frame]) {
        self.currentCity = city;
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _currentStle = [[CSLSetingDal sharedInstance] getCurrentTheme];
        //整个的背景图片
//        _bgImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dbgWidget.png",_currentStle]]];
        NSLog(@"%@",[NSBundle mainBundle].bundlePath);
        _bgImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3bgWidget.png"]];
        [_bgImageView setFrame:CGRectMake(0, 0, kWidth, kheight)];
        [self addSubview:_bgImageView];
        
        //时间背景图片
//        _clockbgBgImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dbgWidgetClock.png",_currentStle]]];
        _clockbgBgImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3bgWidgetClock.png"]];
        [_clockbgBgImgView setFrame:CGRectMake(0, 0, kWidth, kheight)];
        [self addSubview:_clockbgBgImgView];
        
        _effectBgImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"effect_clear.png"]];
        [_effectBgImgView setFrame:CGRectMake(0, 0, kWidth, kheight)];
        [self addSubview:_effectBgImgView];
        
        _lblDate = [[UILabel alloc] init];
        [_lblDate setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [_lblDate setTextAlignment:NSTextAlignmentCenter];
        [_lblDate setFrame:CGRectMake(kWidth/375*125, kheight/667*18, kWidth/375*118, kheight/667*27)];
        _lblPlace.backgroundColor = [UIColor cyanColor];
        [_effectBgImgView addSubview:_lblDate];
        
        _hourLeftImgView=[[UIImageView alloc] init];
        [_hourLeftImgView setFrame:CGRectMake(kWidth/375*59,kheight/667*70,kWidth/375*55,kheight/667*102)];
        [_effectBgImgView addSubview:_hourLeftImgView];
        
        _hourRightImgView=[[UIImageView alloc] init];
        [_hourRightImgView setFrame:CGRectMake(kWidth/375*114,kheight/667*70,kWidth/375*55,kheight/667*102)];
        [_effectBgImgView addSubview:_hourRightImgView];
        
        _minuteLeftImgView=[[UIImageView alloc] init];
        [_minuteLeftImgView setFrame:CGRectMake(kWidth/375*194,kheight/667*70,kWidth/375*55,kheight/667*102)];
        [_effectBgImgView addSubview:_minuteLeftImgView];
        
        _minuteRightImgView=[[UIImageView alloc] init];
        [_minuteRightImgView setFrame:CGRectMake(kWidth/375*249,kheight/667*70,kWidth/375*55,kheight/667*102)];
        [_effectBgImgView addSubview:_minuteRightImgView];
        
        //正中间的天气图像
        _todayImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clear.png"]];
        [_todayImgView setFrame:CGRectMake(kWidth/375*97,kheight/667*175,kWidth/375*180,kheight/667*180)];
        [_effectBgImgView addSubview:_todayImgView];
        
        //地点标签
        _lblPlace=[[UILabel alloc] init];
        [_lblPlace setBackgroundColor:[UIColor clearColor]];
        [_lblPlace setTextColor:[UIColor whiteColor]];

        [_lblPlace setFont:[UIFont systemFontOfSize:24]];
        [_lblPlace setText:@""];
        _lblPlace.frame = CGRectMake(kWidth/375*20,kheight/667*309,kWidth/375*93,kheight/667*33);
        [self addSubview:_lblPlace];
        
        //温度标签
        _lblTemp=[[UILabel alloc] init];
        [_lblTemp setBackgroundColor:[UIColor clearColor]];
        [_lblTemp setTextColor:[UIColor whiteColor]];
        [_lblTemp setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [_lblTemp setTextAlignment:NSTextAlignmentRight];
        [_lblTemp setFrame:CGRectMake(kWidth/375*235,kheight/667*309,kWidth/375*115,kheight/667*33)];
        [_lblTemp setText:@""];
        [_effectBgImgView addSubview:_lblTemp];
        
        //添加天气信息标签
        _lblWeather=[[UILabel alloc] init];
        [_lblWeather setBackgroundColor:[UIColor clearColor]];
        [_lblWeather setTextColor:[UIColor whiteColor]];
        [_lblWeather setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [_lblWeather setFrame:CGRectMake(kWidth/375*20,kheight/667*355,kWidth/375*115,kheight/667*33)];
        [_lblWeather setText:@""];
        [_effectBgImgView addSubview:_lblWeather];
        
        //风类标签
        _lblWind=[[UILabel alloc] init];
        [_lblWind setBackgroundColor:[UIColor clearColor]];
        [_lblWind setTextColor:[UIColor whiteColor]];
        [_lblWind setTextAlignment:NSTextAlignmentRight];
        [_lblWind setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [_lblWind setFrame:CGRectMake(kWidth/375*240,kheight/667*345,kWidth/375*115,kheight/667*26)];
        [_lblWind setText:@""];
        [_effectBgImgView addSubview:_lblWind];
        
        //风类级别标签
        _lblWindLevel=[[UILabel alloc] init];
        [_lblWindLevel setBackgroundColor:[UIColor clearColor]];
        [_lblWindLevel setTextColor:[UIColor whiteColor]];
        [_lblWindLevel setTextAlignment:NSTextAlignmentRight];
        [_lblWindLevel setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [_lblWindLevel setFrame:CGRectMake(kWidth/375*240,kheight/667*370,kWidth/375*115,kheight/667*26)];
        [_lblWindLevel setText:@""];
        [_effectBgImgView addSubview:_lblWindLevel];
        
        UICollectionViewFlowLayout * flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.itemSize = CGSizeMake(kWidth/375/4*343, kheight/667*120);
        flowlayout.minimumInteritemSpacing = 0;
        _futureWeather = [[UICollectionView alloc] initWithFrame:CGRectMake(kWidth/375*15,kheight/667*399,kWidth/375*343,kheight/667*120) collectionViewLayout:flowlayout];
        _futureWeather.backgroundColor = [UIColor clearColor];
        [_effectBgImgView addSubview:_futureWeather];
        _futureWeather.dataSource = self;
        UINib * nib = [UINib nibWithNibName:@"CSLCollectionViewCell" bundle:nil];
        [_futureWeather registerNib:nib forCellWithReuseIdentifier:cellIndentifier];
        [self updateTime:nil];
        [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    }
    return self;
}
//显示天气
-(void)updateMainInThread:(CSLWeatherModel *)city {
    _lblDate.text = city.today.date;
    NSString * todayimg = [[CSLWeatherDAL sharedInstaced] getImageNameFromString:city.today.type];
    _todayImgView.image = [UIImage imageNamed:todayimg];
    _lblPlace.text = city.city;
    _lblWeather.text = city.today.type;
    _lblWind.text = city.today.fengxiang;
    _lblWindLevel.text = city.today.fengli;
    _lblTemp.text = [NSString stringWithFormat:@"%@~%@",city.today.lowtemp,city.today.hightemp];
    NSString * effectImg = [[CSLWeatherDAL sharedInstaced] getImageNameFromString:city.today.type];
    [_effectBgImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"effect_%@.png",effectImg]]];
    _array = [NSMutableArray arrayWithArray:city.forecast];
    [_futureWeather reloadData];
}

//得到时间
-(NSDateComponents *)getCurrentNSDateComponent {
    NSDate *startDate=[[NSDate alloc] init];
    NSCalendar *chineseCalender=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSUInteger unitFlag = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    return [chineseCalender components:unitFlag fromDate:startDate];
}

-(void)updateTime:(NSTimer *)timer {
    //ThemeStyle style=[[CSLSetingDal sharedInstance] getCurrentTheme];
    ThemeStyle style = ThemeBlueStyle;
    NSDateComponents *dateComponents=[self getCurrentNSDateComponent];
    //得到小时
    long hour=[dateComponents hour];
    int hourRight=hour%10;
    if(hour<10)
    {
        [_hourLeftImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%d.png",style,0]]];
    }
    else
    {
        long hourLeft=hour/10;
        NSLog(@"%@",[NSString stringWithFormat:@"%d%ld.png",style,hourLeft]);
        [_hourLeftImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%ld.png",style,hourLeft]]];
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%d%d.png",style,hourRight]);
    [_hourRightImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%d.png",style,hourRight]]];
    
    //得到分钟
    long minute=[dateComponents minute];
    int minuteRight=minute%10;
    if(minute<10)
    {
        [_minuteLeftImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%d.png",style,0]]];
    }
    else
    {
        long minuteLeft=minute/10;
        
        [_minuteLeftImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%ld.png",style,minuteLeft]]];
    }
    [_minuteRightImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d%d.png",style,minuteRight]]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CSLCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    CSLDayWeatherModel * model = _array[indexPath.row];

    NSString *weatherImgName=[[CSLWeatherDAL sharedInstaced] getImageNameFromString:[model valueForKey:@"type"]];
    
    cell.Date.text = [model valueForKey:@"week"];
    cell.weatherImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",weatherImgName]];
    cell.Temp.text = [NSString stringWithFormat:@"%@~%@",[model valueForKey:@"lowtemp"],[model valueForKey:@"hightemp"]];

    return cell;
}

@end
