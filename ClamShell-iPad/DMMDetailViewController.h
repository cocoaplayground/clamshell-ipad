//
//  DMMDetailViewController.h
//  ClamShell-iPad
//
//  Created by Delisa Mason on 5/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMMDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
