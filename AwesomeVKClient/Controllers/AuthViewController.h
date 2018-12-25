//
//  AuthViewController.h
//  AwesomeVKClient
//
//  Created by Никита on 24/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController<UIWebViewDelegate> {
    __weak IBOutlet UIWebView *webView;
    __weak IBOutlet UIActivityIndicatorView *activityIndicatorView;
    __weak IBOutlet UIButton *authButton;
}

@end
