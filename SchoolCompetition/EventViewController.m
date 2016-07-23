//
//  EventViewController.m
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
#import <Parse/Parse.h>
#import "CustomAlert.h"


@interface EventViewController () {
    NSString *eventContent;
    NSString *dateString;
    NSString *againstTeam;
}

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMenuDropDown];
    self.addBtn.titleLabel.text = @"TOM";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuDropDown {
    dropdown = [[LHDropDownControlView alloc]initWithFrame:CGRectMake(278, 31, 97, 30)];
    dropdown.title = @"Menu";
    dropdown.delegate = self;
    NSArray *index = [[NSArray alloc]init];
    NSArray *title = [[NSArray alloc]init];
    index = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    title = [NSArray arrayWithObjects:@"Schedule", @"Current Game", @"Leader Board", @"Competition", @"Event", @"Log out", nil];
    [dropdown setSelectionOptions:index withTitles:title];
    [self.view addSubview:dropdown];
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
        {
            if (permission != 0) {
                break;
            }
            CompetitionViewController *competitionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"competitionViewController"];
            [self.navigationController pushViewController:competitionVC animated:YES];
        }
            break;
        case 5:
        {
            if (permission != 0) {
                break;
            }
            EventViewController *eventVC = [self.storyboard instantiateViewControllerWithIdentifier:@"eventViewController"];
            [self.navigationController pushViewController:eventVC animated:YES];
        }

        case 6:{
            ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"viewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
}

- (IBAction)teamBtn:(id)sender {
    NSArray *periodDropdown = [NSArray arrayWithObjects:@"Cereal Killaz",@"Gators",@"Gym Class Crew",@"Lob City",@"Math Sucks",@"Monkey Time",@"Pandas",@"Pirates", nil];
    AJDropDownPicker *picker = [[AJDropDownPicker alloc]initWithDelegate:self dataSourceArray:periodDropdown];
    [picker showFromView:sender];
}

#pragma mark - dropdown

- (void)dropDownPicker:(AJDropDownPicker *)dropDownPicker didPickObject:(id)pickedObject {
    [self.teamSelect setTitle:pickedObject forState:UIControlStateNormal];
    toteam = self.teamSelect.titleLabel.text;
}


- (IBAction)dateChanged:(id)sender {
    NSDate *myDate = self.dataPicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd hh:mm aa"];
    dateString = [dateFormat stringFromDate:myDate];
}

- (IBAction)addBtn:(id)sender {
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"team1"] = team;
    event[@"team2"] = self.teamSelect.titleLabel.text;
    event[@"date"] = dateString;
    event[@"content"] = self.eventText.text;
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"success");
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Success" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
            [alert showInView:self.view];
        }
        else{
            NSLog(@"fail");
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Warning" message:@"Please fill data :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
            [alert showInView:self.view];
        }
    }];
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
