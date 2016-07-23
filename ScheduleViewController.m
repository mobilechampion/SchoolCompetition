//
//  ScheduleViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "AppDelegate.h"
#import "ScheduleViewController.h"
#import "NIDropDown.h"
#import "ViewController.h"
#import "CurrentGameViewController.h"
#import "LeaderViewController.h"
#import "CompetitionViewController.h"
#import "EventViewController.h"
#import "LHDropDownControlView.h"
#import "HomeCustomTableViewCell.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface ScheduleViewController () {
    MBProgressHUD *loading;
}

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eventTable.delegate = self;
    self.eventTable.dataSource = self;
    [self setMenuDropDown];
    self.avatarImg.layer.cornerRadius = self.avatarImg.layer.frame.size.height/2;
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.layer.borderWidth = 0;
    
    self.callBtn.layer.cornerRadius = self.callBtn.layer.frame.size.height/10;
    self.callBtn.layer.borderWidth = 1.0f;
    
    self.emailBtn.layer.cornerRadius = self.emailBtn.layer.frame.size.height/10;
    self.emailBtn.layer.borderWidth = 1.0f;
    
//    [self presentModalViewController:mailer animated:YES];
    
//    [self getEventArr];
}

- (void)getEventArr {
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelText = @"fetching...";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"team1" equalTo:team];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] != 0) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"%@", objects);
//            eventArr = objects;
//            NSLog(@"event array = %@", eventArr);
            [self tableView:self.eventTable numberOfRowsInSection:0];
            for (int i = 0 ; i < [objects count]; i ++ ) {
                static NSString *CellIdentifier = @"CustomCell";
                HomeCustomTableViewCell *cell = (HomeCustomTableViewCell * )[self.eventTable dequeueReusableCellWithIdentifier:CellIdentifier];
                cell.backgroundColor = [UIColor clearColor];
                cell.date.text = [[objects objectAtIndex:i] valueForKey:@"date"];
                cell.content.text = [[objects objectAtIndex:i] valueForKey:@"content"];
            }
        }
        
    }];
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
        case 1:
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
    cell.date.text = [[event objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.content.text = [[event objectAtIndex:indexPath.row] valueForKey:@"content"];
    // Display recipe in the table cell
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [event count];
}

- (IBAction)callBtn:(id)sender {
    
}

- (IBAction)emailBtn:(id)sender {

    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
        mailer.mailComposeDelegate = self;
            
        [mailer setSubject:@""];
            
        NSArray *toRecipients = [NSArray arrayWithObjects:@"", @"", nil];
        [mailer setToRecipients:toRecipients];
            
        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
            
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
            
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                            message:@"Your device doesn't support the composer sheet"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
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
