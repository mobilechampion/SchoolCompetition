//
//  CurrentSubViewController.h
//  SchoolCompetition
//
//  Created by gold on 4/14/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHDropDownControlView.h"
#import "MBProgressHUD.h"

@interface CurrentSubViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, LHDropDownControlViewDelegate> {
    LHDropDownControlView *dropdown;
    MBProgressHUD *loading;
}

@property (nonatomic, retain)NSString *selectedTeamName;

@property (strong, nonatomic) IBOutlet UIImageView *avatarImg;
@property (strong, nonatomic) IBOutlet UIImageView *team1Mark;
@property (strong, nonatomic) IBOutlet UILabel *team1Name;
@property (strong, nonatomic) IBOutlet UILabel *team1Score;
@property (strong, nonatomic) IBOutlet UIImageView *team2Mark;
@property (strong, nonatomic) IBOutlet UILabel *team2Name;
@property (strong, nonatomic) IBOutlet UILabel *team2Score;

@property (strong, nonatomic) IBOutlet UITableView *currentTeamScoreTable;
@property (strong, nonatomic) IBOutlet UILabel *teamName;

@property (strong, nonatomic) IBOutlet UIButton *againTeamBtn;


@end
