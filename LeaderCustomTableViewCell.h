//
//  LeaderCustomTableViewCell.h
//  SchoolCompetition
//
//  Created by gold on 4/13/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderCustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *team1Mark;
@property (strong, nonatomic) IBOutlet UILabel *team1Name;
@property (strong, nonatomic) IBOutlet UILabel *wNum;
@property (strong, nonatomic) IBOutlet UILabel *lNum;
@property (strong, nonatomic) IBOutlet UILabel *tNum;

@end
