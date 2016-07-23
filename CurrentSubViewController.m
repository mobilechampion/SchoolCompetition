//
//  CurrentSubViewController.m
//  SchoolCompetition
//
//  Created by gold on 4/14/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "AppDelegate.h"
#import "CurrentSubViewController.h"
#import "CurrentGameTableViewCell.h"
#import "ScheduleViewController.h"
#import "LeaderViewController.h"
#import "CompetitionViewController.h"
#import "EventViewController.h"
#import "ViewController.h"
#import "CurrentGameViewController.h"
#import "Member.h"
#import <Parse/Parse.h>
#import "AppConstants.h"

@interface CurrentSubViewController () {
    NSInteger attemptNum, pointNum;
    NSInteger ident;
}

@end

@implementation CurrentSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ident = attemptNum = pointNum = 0;
    self.currentTeamScoreTable.delegate = self;
    self.currentTeamScoreTable.dataSource = self;
    [self setMenuDropDown];
    
    NSLog(@"selected team : %@, against : %@", self.selectedTeamName, self.againTeamBtn.titleLabel.text);
    //againTeam button
    self.againTeamBtn.layer.cornerRadius = self.againTeamBtn.frame.size.height/5;
    if ([self.selectedTeamName isEqual:team]) {
        self.againTeamBtn.backgroundColor = [UIColor colorWithRed:10/255.00f green:176/255.00f blue:66/255.00f alpha:1.0f];
        [self.againTeamBtn setTitle:toteam forState:UIControlStateNormal];
    }
    else if ([self.selectedTeamName isEqual:toteam]){
        self.againTeamBtn.backgroundColor = [UIColor colorWithRed:255/255.00f green:143/255.00f blue:0/255.00f alpha:1.0f];
        [self.againTeamBtn setTitle:team forState:UIControlStateNormal];
    }
    
    //bracket displaying party
    self.team1Mark.image = [UIImage imageNamed:team];
    self.team2Mark.image = [UIImage imageNamed:toteam];
    self.team1Name.text = team;
    self.teamName.text = self.selectedTeamName;
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
   
    NSLog(@"team1Name ; %@", self.team1Name.text);
    //avatar image circled
    self.avatarImg.layer.cornerRadius = self.avatarImg.layer.frame.size.height/2;
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.borderWidth = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self geteachTeamEntireScore:self.selectedTeamName];
}

- (void)geteachTeamEntireScore:(NSString *)thisTeam {
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelText = @"loading...";
    entireScoreInTeamArr = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"StudentInfo"];
    [query whereKey:@"team" equalTo:thisTeam];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSString *firstName;
        NSString *lastName;
        NSString *fullname;
        NSLog(@"%@",objects);
        for (int i = 0; i < [objects count]; i ++) {
            firstName = [[objects objectAtIndex:i]valueForKey:@"firstname"];
            lastName = [[objects objectAtIndex:i]valueForKey:@"lastname"];
            fullname = [firstName stringByAppendingString:lastName ];
            [entireScoreInTeamArr addObject:fullname];
            PFQuery *query = [PFQuery queryWithClassName:@"Competition"];
            if ([self.selectedTeamName isEqual:team]) {
                [query whereKey:@"member1" equalTo:fullname];
            }
            else if ([self.selectedTeamName isEqual:toteam]){
                [query whereKey:@"member2" equalTo:fullname];
            }
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                attemptNum = [objects count];
                for (int i = 0; i < attemptNum; i ++) {
                    if ([self.selectedTeamName isEqual:team]) {
                        if ([[[objects objectAtIndex:i] valueForKey:@"stats"]isEqual:@"WIN"]) {
                            pointNum = pointNum + 1;
                        }
                    }
                    else if ([self.selectedTeamName isEqual:toteam]){
                        if ([[[objects objectAtIndex:i] valueForKey:@"stats"]isEqual:@"LOSS"]) {
                            pointNum = pointNum + 1;
                        }
                    }
                }
                Member *mem = [[Member alloc]init];
                mem.name = fullname;
                mem.att = attemptNum;
                mem.po= pointNum;
                [entireScoreInTeamArr replaceObjectAtIndex:[entireScoreInTeamArr indexOfObject:fullname] withObject:mem];
                ident ++;
                if ([entireScoreInTeamArr count] == ident) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                    [self.currentTeamScoreTable reloadData];
                }
            }];
        }
    }];
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
            CurrentGameViewController *scheduleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"currentGameViewController"];
            [self.navigationController pushViewController:scheduleVC animated:YES];
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

- (IBAction)againTeamStatsBtn:(id)sender {
    if ([self.selectedTeamName isEqual:team]) {
        self.selectedTeamName = toteam;
    }
    else if ([self.selectedTeamName isEqual:toteam]) {
        self.selectedTeamName = team;
    }
    [self viewDidLoad];
    [self viewWillAppear:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CurrentTableCell";
    CurrentGameTableViewCell *cell = (CurrentGameTableViewCell * )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    Member *mem = [entireScoreInTeamArr objectAtIndex:indexPath.row];
    cell.memberName.text = mem.name;
    if ([mem.name isEqual:[userFirstname stringByAppendingString:userLastname]]) {
        cell.backgroundColor = [UIColor grayColor];
    }
    cell.attemapts.text = [NSString stringWithFormat:@"%ld", (long)mem.att];
    cell.points.text = [NSString stringWithFormat:@"%ld", (long)mem.po];
    // Display recipe in the table cell
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [entireScoreInTeamArr count];
}


@end
