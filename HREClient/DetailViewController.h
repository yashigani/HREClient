//
//  DetailViewController.h
//  HREClient
//
//  Created by taiki on 2/15/14.
//  Copyright (c) 2014 taiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
