//
//  LeaderViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "team.h"


@interface LeaderViewController : UIViewController<LHDropDownControlViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    LHDropDownControlView *dropdown;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
