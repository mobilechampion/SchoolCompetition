//
//  CompetitionViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "AppDelegate.h"
#import "EventViewController.h"
#import "ScheduleViewController.h"
#import "CurrentGameViewController.h"
#import "LeaderViewController.h"
#import "CompetitionViewController.h"
#import "ViewController.h"
#import "MBProgressHUD.h"
#import "CustomAlert.h"
#import <Parse/Parse.h>

@interface CompetitionViewController () {
    NSArray *teamArr;
    NSInteger team1Index;
    NSInteger team2Index;
    UIButton *btn;
    
    NSString *bracket;
    NSString *team1;
    NSString *team2;
    NSString *mem1;
    NSString *mem2;
    NSString *period;
    NSString *stats;
    
    MBProgressHUD *uploading;
}

@end

@implementation CompetitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    team1Index = team2Index = 0;
    self.competitionResult.selectedSegmentIndex = 0;
    stats = @"WIN";
    [self setMenuDropDown];
    [self teamMarkSlot];
}

- (void)teamMarkSlot {
    teamArr = [NSArray arrayWithObjects:@"Gym Class Crew", @"Cereal Killaz", @"Pandas", @"Lob City", @"Monkey Time", @"Pirates", @"Gators", @"Math Sucks", nil];
    [self changeTeam1Mark];
    [self changeTeam2Mark];
}

- (void)changeTeam1Mark {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageChange1:)];
    [self.team1Mark addGestureRecognizer:singleTap];
    [self.team1Mark setUserInteractionEnabled:YES];
    [self.view addSubview:self.team1Mark];

}

- (void)changeTeam2Mark {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageChange2:)];
    [self.team2Mark addGestureRecognizer:singleTap];
    [self.team2Mark setUserInteractionEnabled:YES];
    [self.view addSubview:self.team2Mark];

}

- (void)imageChange1:(UIGestureRecognizer *) gestureRecognizer {
    NSLog(@"index = %ld", (long)team1Index);
        switch (team1Index) {
        case 0: {
            team1Index = 1;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]] ;
            [self.view addSubview:self.team1Mark];
            NSLog(@"case0 index = %ld", (long)team1Index );
            break;
        }
        case 1: {
            team1Index = 2;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        case 2: {
            team1Index = 3;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        case 3: {
            team1Index = 4;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        case 4: {
            team1Index = 5;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        case 5: {
            team1Index = 6;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        case 6: {
            team1Index = 7;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        case 7: {
            team1Index = 0;
            self.team1Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team1Index]];
            [self.view addSubview:self.team1Mark];
            break;
        }

        default:
            break;
    }
    team1 = [teamArr objectAtIndex:team1Index];
}

- (void)imageChange2:(UIGestureRecognizer *) gestureRecognizer {
    switch (team2Index) {
        case 0: {
            team2Index = 1;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
        case 1: {
            team2Index = 2;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        case 2: {
            team2Index = 3;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        case 3: {
            team2Index = 4;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        case 4: {
            team2Index = 5;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        case 5: {
            team2Index = 6;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        case 6: {
            team2Index = 7;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        case 7: {
            team2Index = 0;
            self.team2Mark.image = [UIImage imageNamed:[teamArr objectAtIndex:team2Index]];
            [self.view addSubview:self.team2Mark];
            break;
        }
            
        default:
            break;
    }
     team2 = [teamArr objectAtIndex:team2Index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuDropDown {
    //menu dropdown
    menuDropdown = [[LHDropDownControlView alloc]initWithFrame:CGRectMake(278, 31, 97, 30)];
    menuDropdown.title = @"Menu";
    menuDropdown.delegate = self;
    NSArray *index = [[NSArray alloc]init];
    NSArray *title = [[NSArray alloc]init];
    index = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    title = [NSArray arrayWithObjects:@"Schedule", @"Current Game", @"Leader Board", @"Competition", @"Event", @"Log out", nil];
    [menuDropdown setSelectionOptions:index withTitles:title];
    [self.view addSubview:menuDropdown];
}

- (IBAction)periodBtn:(id)sender {
    btn = sender;
    NSArray *periodDropdown = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    AJDropDownPicker *picker = [[AJDropDownPicker alloc]initWithDelegate:self dataSourceArray:periodDropdown];
    [picker showFromView:sender];
}

- (IBAction)bracketBtn:(id)sender {
    btn = sender;
    NSArray *bracketDropdown = [NSArray arrayWithObjects:@"Bracket A", @"Bracket B", @"Bracket C", @"Bracket D", nil ];
    AJDropDownPicker *picker = [[AJDropDownPicker alloc]initWithDelegate:self dataSourceArray:bracketDropdown];
    [picker showFromView:sender];
}

- (IBAction)team1MemBtn:(id)sender {
    btn = sender;
    NSMutableArray *team1Member = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"StudentInfo"];
    NSLog(@"teamIndex = %ld", (long)team1Index);
    NSString *team1 = [teamArr objectAtIndex:team1Index];
    NSLog(@"team :%@", team1);
    [query whereKey:@"team" equalTo:team1];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        NSString *firstName;
        NSString *lastName;
        NSString *fullname;
        for (int i = 0; i < [objects count]; i ++) {
            firstName = [[objects objectAtIndex:i]valueForKey:@"firstname"];
            lastName = [[objects objectAtIndex:i]valueForKey:@"lastname"];
            fullname = [firstName stringByAppendingString:lastName ];
            [team1Member addObject:fullname];
            [team1Member sortUsingSelector:@selector(compare:)];
        }
        AJDropDownPicker *picker = [[AJDropDownPicker alloc]initWithDelegate:self dataSourceArray:team1Member];
        [picker showFromView:sender];

    }];
    
}

- (IBAction)team2MemBtn:(id)sender {
    btn = sender;
    NSMutableArray *team2Member = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"StudentInfo"];
    NSLog(@"teamIndex = %ld", (long)team2Index);
    NSString *team2 = [teamArr objectAtIndex:team2Index];
    NSLog(@"team :%@", team2);
    [query whereKey:@"team" equalTo:team2];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        NSString *firstName;
        NSString *lastName;
        NSString *fullname;
        for (int i = 0; i < [objects count]; i ++) {
            firstName = [[objects objectAtIndex:i]valueForKey:@"firstname"];
            lastName = [[objects objectAtIndex:i]valueForKey:@"lastname"];
            fullname = [firstName stringByAppendingString:lastName ];
            [team2Member addObject:fullname];
            [team2Member sortUsingSelector:@selector(compare:)];
        }
        AJDropDownPicker *picker = [[AJDropDownPicker alloc]initWithDelegate:self dataSourceArray:team2Member];
        [picker showFromView:sender];
        
    }];

}

#pragma mark - dropdown

- (void)dropDownPicker:(AJDropDownPicker *)dropDownPicker didPickObject:(id)pickedObject {
    switch ([btn tag]) {
        case 200:
            period = pickedObject;
            break;
        case 210:
            bracket = pickedObject;
            break;
        case 220:
            mem1 = pickedObject;
            break;
        case 230:
            mem2 = pickedObject;
            break;
//        case 310:
//            team1 = pickedObject;
//            break;
//        case 320:
//            team2 = pickedObject;
//            break;
        default:
            break;
    }
    [btn setTitle:pickedObject forState:UIControlStateNormal];
}

- (void)dropDownControlViewWillBecomeActive:(LHDropDownControlView *)view {
    
}

- (void)dropDownControlView:(LHDropDownControlView *)view didFinishWithSelection:(id)selection {
    NSLog(@"%ld", (long)[selection integerValue]);
    
    switch ([selection integerValue]) {
        case 1:{
            ScheduleViewController *scheduleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"scheduleViewController"];
            [self.navigationController pushViewController:scheduleVC animated:YES];
        }
            break;
        case 2:{
            CurrentGameViewController *currentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"currentGameViewController"];
            [self.navigationController pushViewController:currentVC animated:YES];
        }
            break;
        case 3:{
            LeaderViewController *leaderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"leaderViewController"];
            [self.navigationController pushViewController:leaderVC animated:YES];
        }
            break;
        case 4:
            break;
        case 5:
        {
            if (permission != 0) {
                break;
            }
            EventViewController *eventVC = [self.storyboard instantiateViewControllerWithIdentifier:@"eventViewController"];
            [self.navigationController pushViewController:eventVC animated:YES];
        }

            break;
        case 6:{
            ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
}

- (IBAction)competitionResult:(id)sender {
    switch (self.competitionResult.selectedSegmentIndex) {
        case 0:
            stats = @"WIN";
            break;
        case 1:
            stats = @"TIE";
            break;
        case 2:
            stats = @"LOSS";
            break;
        default:
            break;
    }
    NSLog(@"game stat; %@", stats);
}


- (IBAction)registerBtn:(id)sender {
    NSLog(@"%@, %@, %@, %@, %@, %@, %@", period, bracket
          , team1, team2, mem1, mem2, stats);
    if (!bracket||!team1||!mem1||!team2||!mem2||!period||!stats) {
        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"error" message:@"Sorry but register failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
        [alert showInView:self.view];
    }
    else {
        uploading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        uploading.labelText = @"uploading...";
        
        PFObject *comp = [PFObject objectWithClassName:@"Competition"];
        comp[@"bracket"] = bracket;
        comp[@"team1"] = team1;
        comp[@"member1"] = mem1;
        comp[@"team2"] = team2;
        comp[@"member2"] = mem2;
        comp[@"period"] = period;
        comp[@"stats"] = stats;
        [comp saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (succeeded) {
                NSLog(@"success");
                CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"success" message:@"Register success" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
                [alert showInView:self.view];
            }
            else{
                NSLog(@"fail");
                CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"error" message:@"Sorry but register failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
                [alert showInView:self.view];
            }
        }];

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
