//
//  AppDelegate.h
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
BOOL permission;
NSString *userFirstname;
NSString *userLastname;

NSString *currentPeriod;
NSString *team;
NSString *toteam;

NSString *teamPeriod1Score;
NSString *teamPeriod2Socre;
NSString *teamPeriod3Score;

NSString *toteamPeriod1Score;
NSString *toteamPeriod2Score;
NSString *toteamPeriod3Score;

NSArray *competition;
NSArray *event;
NSMutableArray *entireScoreInTeamArr;


@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
}
//@property (strong, nonatomic) NSString *team;
//@property (strong, nonatomic) NSString *userFirstname;
//@property (strong, nonatomic) NSString *userLastname;
@property (strong, nonatomic) UIWindow *window;


@end

