//
//  HomeViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "LHDropDownControlView.h"

@interface HomeViewController : UIViewController<LHDropDownControlViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    LHDropDownControlView *dropDown;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UIImageView *teamMarkImg;

@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UILabel *teamRecord;

@property (weak, nonatomic) IBOutlet UIImageView *team1Mark;
@property (weak, nonatomic) IBOutlet UILabel *team1Name;
@property (weak, nonatomic) IBOutlet UIImageView *team2Mark;
@property (weak, nonatomic) IBOutlet UILabel *team2Name;

@property (weak, nonatomic) IBOutlet UILabel *team1Score;
@property (weak, nonatomic) IBOutlet UILabel *team2Score;

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (strong, nonatomic) IBOutlet UILabel *bracketLbl;


@end
