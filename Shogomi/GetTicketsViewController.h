//
//  GetTicketsViewController.h
//  Shogomi
//
//  Created by Peter Kamm on 4/19/13.
//  Copyright (c) 2013 Smatterbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetTicketsViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (strong, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
