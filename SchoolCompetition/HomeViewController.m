//
//  HomeViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "NIDropDown.h"
#import "LHDropDownControlView.h"
#import "ScheduleViewController.h"
#import "CurrentGameViewController.h"
#import "LeaderViewController.h"
#import "CompetitionViewController.h"
#import "EventViewController.h"
#import "HomeCustomTableViewCell.h"
#import <Parse/Parse.h>

@interface HomeViewController () {
    NSArray *compArr;
    NSInteger score00, score01, score02;
    NSInteger score10, score11, score12;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table.delegate = self;
    self.table.dataSource = self;
    //avatar circled
    NSLog(@"%d", permission);
    self.avatarImg.layer.cornerRadius = self.avatarImg.layer.frame.size.height/2;
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.borderWidth = 0;
    
    //Team distinguish
    self.teamName.text = team;
    self.team1Name.text = team;
    self.teamMarkImg.image = [UIImage imageNamed:self.teamName.text];
    self.team1Mark.image = [UIImage imageNamed:self.team1Name.text];
    [self getScore];
    
    //avatar image touching
    self.avatarImg.image = [UIImage imageNamed:@"avatar.png"];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTaped:)];
    [self.avatarImg addGestureRecognizer:singleTap];
    [self.avatarImg setUserInteractionEnabled:YES];
    [self.view addSubview:self.avatarImg];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self setMenuDropDown];
}

- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.avatarImg.alpha = 1.0f;
        [self profileSet];
    }];
}

- (void)profileSet {
    ProfileViewController *proVCInstance = [self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
    proVCInstance.firstName1 = userFirstname;
    proVCInstance.lastName1 = userLastname;
    proVCInstance.teamSelect.titleLabel.text = team;
    proVCInstance.isFromStartup = FALSE;
    [self.navigationController pushViewController:proVCInstance animated:YES];
}

- (void)getScore {

        self.bracketLbl.text = [[competition objectAtIndex:0]valueForKey:@"bracket"];
        toteam = [[competition lastObject]valueForKey:@"team2"];
        self.team2Name.text = toteam;
        self.team2Mark.image = [UIImage imageNamed:toteam];
        for (int i = 0; i < [competition count]; i ++) {
            if ([[[competition objectAtIndex:i]valueForKey:@"period"] isEqual:@"1"]) {
                if ([[[competition objectAtIndex:i]valueForKey:@"stats"] isEqual:@"WIN"]) {
                    score00 = score00 + 1;
                }
                else if ([[[competition objectAtIndex:i]valueForKey:@"stats"] isEqual:@"LOSS"]) {
                    score10 = score10 + 1;
                }
                
            }
            else if ([[[competition objectAtIndex:i]valueForKey:@"period"] isEqual:@"2"]) {
                if ([[[competition objectAtIndex:i]valueForKey:@"stats"] isEqual:@"WIN"]) {
                    score01 = score01 + 1;
                }
                else if ([[[competition objectAtIndex:i]valueForKey:@"stats"] isEqual:@"LOSS"]) {
                    score11 = score11 + 1;
                }
            }
            else if ([[[competition objectAtIndex:i]valueForKey:@"period"] isEqual:@"3"]) {
                if ([[[competition objectAtIndex:i]valueForKey:@"stats"] isEqual:@"WIN"]) {
                    score02 = score02 + 1;
                }
                else if ([[[competition objectAtIndex:i]valueForKey:@"stats"] isEqual:@"LOSS"]) {
                    score12 = score12 + 1;
                }
            }
        }
        NSString *record = [[NSString stringWithFormat:@"%ld", (long)score00]stringByAppendingString:@"-"];
        record = [record stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)score01]];
        record = [record stringByAppendingString:@"-"];
        record = [record stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)score02]];
        self.teamRecord.text = record;
    
    
        //current score
        teamPeriod1Score = [NSString stringWithFormat:@"%ld", (long)score00];
        toteamPeriod1Score = [NSString stringWithFormat:@"%ld", (long)score10];
        teamPeriod2Socre = [NSString stringWithFormat:@"%ld", (long)score01];
        toteamPeriod2Score = [NSString stringWithFormat:@"%ld", (long)score11];
        teamPeriod3Score = [NSString stringWithFormat:@"%ld", (long)score02];
        toteamPeriod3Score = [NSString stringWithFormat:@"%ld", (long)score12];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuDropDown {
    dropDown = [[LHDropDownControlView alloc]initWithFrame:CGRectMake(278, 31, 97, 30)];
    dropDown.title = @"Menu";
    dropDown.delegate = self;
    NSArray *index = [[NSArray alloc]init];
    NSArray *title = [[NSArray alloc]init];
    index = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    title = [NSArray arrayWithObjects:@"Schedule", @"Current Game", @"Leader Board", @"Competition", @"Event", @"Log out", nil];
    [dropDown setSelectionOptions:index withTitles:title];
    [self.view addSubview:dropDown];
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

@end
