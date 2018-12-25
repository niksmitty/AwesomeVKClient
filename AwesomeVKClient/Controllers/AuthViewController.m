//
//  AuthViewController.m
//  AwesomeVKClient
//
//  Created by Никита on 24/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "AuthViewController.h"
#import "VkAPIManager.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView.hidden = YES;
    webView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:VkAPIOAuthBaseUrlPatternString,
                                                                               appId,
                                                                               groupIds,
                                                                               displayType,
                                                                               redirectUri,
                                                                               [@(WallType + DocsType) stringValue],
                                                                               responseType,
                                                                               apiVersion]]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->activityIndicatorView startAnimating];
        [self->webView loadRequest:request];
    });
}

#pragma mark - Actions

- (IBAction)authButtonTapped:(UIButton *)sender {
    authButton.hidden = YES;
    webView.hidden = NO;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)_webView {
    NSString *urlString = _webView.request.URL.absoluteString;
    if ([urlString rangeOfString:@"access_token"].location != NSNotFound) {
        NSString *accessToken = [urlString getStringBetweenString:@"access_token=" andString:@"&"];
        [[VkAPIManager sharedInstance] setAccessToken:accessToken];
        [self performSegueWithIdentifier:@"SHOW_FUNCTIONS" sender:self];
    } else if ([urlString rangeOfString:@"error"].location != NSNotFound) {
        NSLog(@"%@", urlString);
    } else {
        authButton.hidden = NO;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->activityIndicatorView stopAnimating];
    });
}

@end
