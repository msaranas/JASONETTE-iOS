//
//  DEMOSecondViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#import "NavigationViewController.h"

@interface DEMOSecondViewController ()

@end

@implementation DEMOSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Second Controller";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(NavigationViewController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

@end
