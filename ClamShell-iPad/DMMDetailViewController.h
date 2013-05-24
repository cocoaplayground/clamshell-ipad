//
//  DMMDetailViewController.h
//  ClamShell-iPad
//
//  Created by Delisa Mason on 5/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMMSearchResult.h"

@interface DMMDetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) DMMSearchResult *detailItem;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
