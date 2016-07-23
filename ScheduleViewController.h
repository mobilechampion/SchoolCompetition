//
//  ScheduleViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHDropDownControlView.h"
#import <MessageUI/MessageUI.h>

@interface ScheduleViewController : UIViewController<LHDropDownControlViewDelegate, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate> {
    LHDropDownControlView *dropdown;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;

@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (strong, nonatomic) IBOutlet UITableView *eventTable;

@end
