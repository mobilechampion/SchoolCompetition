//
//  LeaderViewController.m
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
#import "LeaderCustomTableViewCell.h"
#import "MBProgressHUD.h"
#import "Team.h"
#import <Parse/Parse.h>

@interface LeaderViewController () {
    NSMutableArray *allTeamList;
    NSMutableArray *allTeamScoreList;
    MBProgressHUD *loading;
}

@end

@implementation LeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    self.avatarImg.layer.cornerRadius = self.avatarImg.layer.frame.size.height/2;
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.borderWidth = 0;

    
    [self setMenuDropDown];
    allTeamList = (NSMutableArray*) [NSArray arrayWithObjects:@"Cereal Killaz",@"Gators",@"Gym Class Crew",@"Lob City",@"Math Sucks",@"Monkey Time",@"Pandas",@"Pirates", nil];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelText = @"loading";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self getTeamScore];
}

- (void)getTeamScore {
    allTeamScoreList = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < [allTeamList count]; i ++) {
        PFQuery *queryComp = [PFQuery queryWithClassName:@"Competition"];
        [queryComp whereKey:@"team1" equalTo:[allTeamList objectAtIndex:i]];
        [queryComp findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            Team *eachTeam = [[Team alloc]init];
            eachTeam.name = [allTeamList objectAtIndex:i];
            for (int i = 0; i < [objects count]; i ++) {
                if ([[[objects objectAtIndex:i]valueForKey:@"stats"] isEqual:@"WIN"]) {
                    eachTeam.wNum = eachTeam.wNum + 1;
                }
                else if ([[[objects objectAtIndex:i]valueForKey:@"stats"] isEqual:@"TIE"]) {
                    eachTeam.tNum = eachTeam.tNum + 1;
                }
                else if ([[[objects objectAtIndex:i]valueForKey:@"stats"] isEqual:@"LOSS"]) {
                    eachTeam.lNum = eachTeam.lNum + 1;
                }
            }
            NSLog(@"%ld, %ld, %ld", (long)eachTeam.wNum, (long)eachTeam.tNum, (long)eachTeam.lNum);
            [allTeamScoreList addObject:eachTeam];
            NSLog(@"allteamlist; %@", allTeamScoreList);
            if ([allTeamList count] == [allTeamScoreList count]) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self.tableView reloadData];
            }
        }];
    }
    
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
        case 3:
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
    static NSString *CellIdentifier = @"CustomLeader";
    LeaderCustomTableViewCell *cell = (LeaderCustomTableViewCell * )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Display recipe in the table cell
    Team *eachTeam = [allTeamScoreList objectAtIndex:indexPath.row];
    cell.team1Mark.image = [UIImage imageNamed:eachTeam.name];
    cell.team1Name.text = eachTeam.name;
    cell.wNum.text = [NSString stringWithFormat:@"%ld",(long)eachTeam.wNum];
    cell.lNum.text = [NSString stringWithFormat:@"%ld", (long)eachTeam.lNum];
    cell.tNum.text = [NSString stringWithFormat:@"%ld", (long)eachTeam.tNum];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [allTeamScoreList count];
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
