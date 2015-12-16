//
//  CSLShopDetailViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLShopDetailViewController.h"
#import "CSLShopInfoModel.h"
#import "UIImageView+AFNetworking.h"

@interface CSLShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *legal;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessLabel;

-(void) setupUI;//页面处理
-(void) requestData;//请求数据
-(void) addGesture;//增加手势
-(void) doWithGesture;//手势处理

@end

@implementation CSLShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Business Detail", nil);
    [self setupUI];
    [self addGesture];
    [self requestData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.dataSource = nil;//释放
    self.topView = nil;
    self.bottomView = nil;
    self.middleView = nil;
}

//请求数据
-(void) requestData{
    self.isLoadIndicator = YES;//显示数据加载指示器
    //查询药店详情
    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopInfo_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3",@"id":[NSNumber numberWithLong:self.compandId]}];
}

-(void) parserData:(id)data{
    NSLog(@"%@",data);
    NSDictionary * result = data[@"result"];
    __autoreleasing NSError * error;
    CSLShopInfoModel * model = [[CSLShopInfoModel alloc] initWithDictionary:result error:&error];
    if (!error) {
        //赋值
        NSString * urlString = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",model.img];
        [self.logoImageView setImageWithURL:[NSURL URLWithString:urlString]];
        self.nameLabel.text = model.name;
        self.typeLabel.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"type",nil),model.type];
        self.countLabel.text = [NSString stringWithFormat:@"%@：%ld",NSLocalizedString(@"access count",nil),model.count];
        self.addressLabel.text = model.address;
        self.legal.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"legal",nil),model.legal];
        self.businessLabel.text =[NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"scope",nil),model.business] ;
        self.createDateLabel.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"tel",nil),model.tel];
    }
    [super parserData:nil];
}

//界面初始化
-(void) setupUI{
    [self layerCorner:self.topView.layer];
    [self layerCorner:self.middleView.layer];
    [self layerCorner:self.bottomView.layer];
    [self layerCorner:self.logoImageView.layer];
}

//视图圆角
-(void) layerCorner:(CALayer*)layer{
    layer.cornerRadius = 10;
    layer.borderWidth = 1;
    layer.masksToBounds = YES;
}

-(void) addGesture{
    self.addressLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doWithGesture)];
    [self.addressLabel addGestureRecognizer:tap];
}

-(void) doWithGesture{
    NSLog(@"dddd");
}
@end
