//
//  CSLWeatherController.m
//  LiveAssistant
//
//  Created by csl on 15/12/22.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLWeatherController.h"
#import "CSLSingleWeatherView.h"
#import "CSLCommonHelper.h"
#import "CSLGetPlace.h"
#import "CSLWeatherModel.h"
#import "CSLDayWeatherModel.h"
#import "CSLWeatherDAL.h"
#import "CSLConstant.h"
#import <CoreLocation/CoreLocation.h>
#import "UMSocial.h"

//屏幕宽度和高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenheight [UIScreen mainScreen].bounds.size.height

#define kNavi 64
#define kNewHeight [UIScreen mainScreen].bounds.size.height-64
@interface CSLWeatherController ()

-(void) setupUI;//创建界面
-(void) locateCity;//定位当前城市
-(void) loadData;//加载数据
- (UIImage *)imageFromView: (UIView *) theView;//获得屏幕截图
@end

@implementation CSLWeatherController
{
    CSLWeatherModel * _wheatherInfo;//当前天气信息
    NSMutableDictionary * _dict;//全国城市ID
    CSLSingleWeatherView *_weatherView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    [self parseCityID];
    [self locateCity];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建界面
-(void) setupUI{
    self.navigationItem.title = NSLocalizedString(@"currentWheather", nil);
    _weatherView = [[CSLSingleWeatherView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNewHeight)];
//    [tmpView updateMainInThread:_wheatherInfo];
    [self.view addSubview:_weatherView];
    
    //添加分享
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]  initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareWheather)];
}


//分享
-(void) shareWheather{
    UIImage * image = [self imageFromView:self.view];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMengAppKey shareText:@"今天天气"
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:nil];

}

//定位城市
-(void) locateCity{
    CSLGetPlace * place = [CSLGetPlace shareInstance];
    [place getPlace:^(NSString *cityName) {
        //获得城市名称
        _currentCityName = cityName;
        [self loadData];
    }];
}

//请求数据
-(void) loadData{
    NSString * cityid = _dict[_currentCityName];
    NSString * string = [NSString stringWithFormat:kBaiDu_Wheather_Url,_currentCityName,cityid];
   
    //中文网址编码
    NSString * url = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self request:url];
}
-(void) parserData:(id)data{
    //json解析
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    __autoreleasing NSError *error;
    CSLWeatherModel * model = [[CSLWeatherModel alloc] initWithDictionary:dict[@"retData"] error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    else{
        [_weatherView updateMainInThread:model];
    }

}

//获得城市ID
- (void)parseCityID {
    NSLog(@"%@",[NSBundle mainBundle].bundlePath);
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
    NSString * string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray * result = [string componentsSeparatedByString:@"\n"];
    for (int i = 0; i < (result.count-1); i++) {
        NSString * str = result[i];
        NSString * string = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSArray * array = [string componentsSeparatedByString:@","];
        [_dict setValue:array[0] forKey:array[1]];
    }
}

- (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
