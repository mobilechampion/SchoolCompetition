//
//  CurrentGameViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentGameViewController : UIViewController<LHDropDownControlViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    LHDropDownControlView *dropdown;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *team1Btn;
@property (weak, nonatomic) IBOutlet UIButton *team2Btn;

@property (strong, nonatomic) IBOutlet UIImageView *team1Mark;
@property (strong, nonatomic) IBOutlet UIImageView *team2Mark;
@property (strong, nonatomic) IBOutlet UILabel *team1Name;
@property (strong, nonatomic) IBOutlet UILabel *team2Name;
@property (strong, nonatomic) IBOutlet UILabel *team1Score;
@property (strong, nonatomic) IBOutlet UILabel *team2Score;


@property (strong, nonatomic) IBOutlet UILabel *team1cri;
@property (strong, nonatomic) IBOutlet UILabel *team2cri;
@property (strong, nonatomic) IBOutlet UILabel *team1Period1Score;
@property (strong, nonatomic) IBOutlet UILabel *team1Period2Score;
@property (strong, nonatomic) IBOutlet UILabel *team1Period3Score;

@property (strong, nonatomic) IBOutlet UILabel *team2Period1Score;
@property (strong, nonatomic) IBOutlet UILabel *team2Period2Score;
@property (strong, nonatomic) IBOutlet UILabel *team2Period3Score;



@property (strong, nonatomic) IBOutlet UITableView *feedTableView;

@end
