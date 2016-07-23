//
//  CurrentGameViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "EventViewController.h"
#import "ScheduleViewController.h"
#import "CurrentGameViewController.h"
#import "LeaderViewController.h"
#import "CompetitionViewController.h"
#import "ViewController.h"
#import "HomeCustomTableViewCell.h"
#import "CurrentSubViewController.h"
#import "AppDelegate.h"
#import "Member.h"
#import <Parse/Parse.h>

@class Member;

@interface CurrentGameViewController (){
    
}

@end

@implementation CurrentGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.feedTableView.delegate = self;
    self.feedTableView.dataSource = self;
    
    [self setMenuDropDown];
    //avatar image circled
    self.avatarImg.layer.cornerRadius = self.avatarImg.layer.frame.size.height/2;
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.borderWidth = 0;
    
    //Team button rounded
    [self.team1Btn setTitle:team forState:UIControlStateNormal];
    self.team1Btn.layer.cornerRadius = self.team1Btn.layer.frame.size.height/10;
    [self.team2Btn setTitle:toteam forState:UIControlStateNormal];
    self.team2Btn.layer.cornerRadius = self.team2Btn.layer.frame.size.height/10;
    
    //bracket displaying party
    self.team1Mark.image = [UIImage imageNamed:team];
    self.team2Mark.image = [UIImage imageNamed:toteam];
    self.team1Name.text = team;
    self.team2Name.text = toteam;
    if ([currentPeriod isEqual:@"1"]) {
        self.team1Score.text = teamPeriod1Score;
        self.team2Score.text = toteamPeriod1Score;
    }
    else if ([currentPeriod isEqual:@"2"]) {
        self.team1Score.text = teamPeriod2Socre;
        self.team2Score.text = toteamPeriod2Score;
    }
    else if ([currentPeriod isEqual:@"3"]) {
        self.team1Score.text = teamPeriod3Score;
        self.team2Score.text = toteamPeriod3Score;
    }

    //each period score displaying
    self.team1cri.text = team;
    self.team1Period1Score.text = teamPeriod1Score;
    self.team1Period2Score.text = teamPeriod2Socre;
    self.team1Period3Score.text = teamPeriod3Score;
    self.team2cri.text = toteam;
    self.team2Period1Score.text = toteamPeriod1Score;
    self.team2Period2Score.text = toteamPeriod2Score;
    self.team2Period3Score.text = toteamPeriod3Score;
//    self
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
        case 2:
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomCell";
    HomeCustomTableViewCell *cell = (HomeCustomTableViewCell * )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    NSString *mem1, *mem2, *stats;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH/MM"];
    NSDate *date = [[competition objectAtIndex:indexPath.row] valueForKey:@"updatedAt"];
    cell.date.text = [format stringFromDate:date];
    
    mem1 = [[competition objectAtIndex:indexPath.row]valueForKey:@"member1"];
    mem2 = [[competition objectAtIndex:indexPath.row]valueForKey:@"member2"];
    stats = [[competition objectAtIndex:indexPath.row]valueForKey:@"stats"];
    NSString * content = [mem1 stringByAppendingString:@"  "];
    content = [content stringByAppendingString:stats];
    content = [content stringByAppendingString:@"  "];
    content = [content stringByAppendingString:mem2];
    NSLog(@"%@, %@,", cell.date.text, content);
    cell.content.text = content;
    
    // Display recipe in the table cell
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [competition count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (IBAction)team1Btn:(id)sender {
    CurrentSubViewController *subVCInstance = [self.storyboard instantiateViewControllerWithIdentifier:@"currentSubViewController"];
    subVCInstance.selectedTeamName = team;
    [self.navigationController pushViewController:subVCInstance animated:YES];
}

- (IBAction)team2Btn:(id)sender {
    CurrentSubViewController *subVCInstance = [self.storyboard instantiateViewControllerWithIdentifier:@"currentSubViewController"];
    subVCInstance.selectedTeamName = toteam;
    [self.navigationController pushViewController:subVCInstance animated:YES];
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
