//
//  JKBsBaseWebViewController.m
//  Pods
//
//  Created by 刘伟强 on 2017/9/2.
//
//

#import "JKBsBaseWebViewController.h"
#import "NSObject+jkNetWorkView.h"
@interface JKBsBaseWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;


@end

@implementation JKBsBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNetWorkView];
    
    self.networkFailView.frame = CGRectMake(0, 0, jkScreenWidth, jkScreenHeight - 64);
    self.networkFailView.hidden = YES;
    
    self.loadingView.myFrame = CGRectMake(0, 0, jkScreenWidth, jkScreenHeight - 64 );
    
    if (self.topTitle) {
        [self setNavTitle:self.topTitle];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.height -= 64;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    [self.view addSubview:self.networkFailView];
    // Do any additional setup after loading the view.
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.loadingView showView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.loadingView hidenView];
    
    self.networkFailView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.loadingView hidenView];
    
    self.networkFailView.hidden = NO;
    @jkWeak(self);
    [self.networkFailView refreshReqeust:^{
        NSURL *url = [NSURL URLWithString:selfWeak.url];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [selfWeak.webView loadRequest:urlRequest];
    }];
}

-(BOOL)shouldAutorotate{
    return NO;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
    if (orient != UIInterfaceOrientationPortrait) {
        orient = UIInterfaceOrientationPortrait;
    }
    return  UIInterfaceOrientationPortrait;
}

-(void)dealloc{
    [self cleanCacheAndCookie];
}

- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
