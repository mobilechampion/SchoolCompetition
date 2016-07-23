//
//  CompetitionViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJDropDownPicker.h"

@interface CompetitionViewController : UIViewController<LHDropDownControlViewDelegate,AJDropDownPickerDelegte> {
    LHDropDownControlView *menuDropdown;    
}

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (weak, nonatomic) IBOutlet UIButton *timeLine;
//@property (weak, nonatomic) IBOutlet UIButton *period;
//@property (weak, nonatomic) IBOutlet UIButton *bracket;

@property (weak, nonatomic) IBOutlet UIImageView *team1Mark;
@property (weak, nonatomic) IBOutlet UIImageView *team2Mark;


@property (weak, nonatomic) IBOutlet UIButton *team1Member;
@property (weak, nonatomic) IBOutlet UIButton *team2Member;

@property (weak, nonatomic) IBOutlet UISegmentedControl *competitionResult;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end
