//
//  CSLDownloadController.m
//  LiveAssistant
//
//  Created by csl on 15/12/27.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDownloadController.h"
#import "AFHTTPRequestOperationManager.h"
#import "DownLoadOperation.h"

#define PictureUrl @"http://www.xiaoxiongbizhi.com/wallpapers/__85/2/n/2n16v79uj.jpg"

@interface CSLDownloadController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation CSLDownloadController
{
    DownLoadOperation* operation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"download", nil);
    [self.progressView setProgress:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)download:(id)sender {
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        __autoreleasing NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    }
    //初始化进度和label
    self.progressView.progress = 0;
    self.progressLabel.text = @"";
    
    operation = [[DownLoadOperation alloc] init];
    [operation downloadWithUrl:PictureUrl
                     cachePath:^NSString *{
                         return path;//缓存路径
                     } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
                         
                         NSLog(@"bytesRead = %lu ,totalBytesRead = %llu totalBytesExpectedToRead = %llu",(unsigned long)bytesRead,totalBytesRead,totalBytesExpectedToRead);
                         float progress = totalBytesRead / (float)totalBytesExpectedToRead;
                         
                         //设置进度
                         [self.progressView setProgress:progress animated:YES];
                         [self.progressLabel setText:[NSString stringWithFormat:@"%.2f%%",progress*100]];
                         UIImage* image = [UIImage imageWithData:operation.requestOperation.responseData];
                         [self.imageView setImage:image];
                         
                     } success:^(AFHTTPRequestOperation *operation, id responseObject) {//下载完成
                         
                         NSLog(@"success");
                         
                         //显示图片
                         UIImage* image = [UIImage imageWithData:operation.responseData];
                         [self.imageView setImage:image];
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"error = %@",error);
                     }];
    

}


- (IBAction)pause:(id)sender {
    [operation.requestOperation pause];
}

- (IBAction)resume:(id)sender {
     [operation.requestOperation resume];
}

@end
