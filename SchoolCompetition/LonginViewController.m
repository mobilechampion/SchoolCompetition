//
//  LonginViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "AppDelegate.h"
#import "LonginViewController.h"
#import "HomeViewController.h"
#import "CustomAlert.h"
#import "ProfileViewController.h"
#import "GMDCircleLoader.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface LonginViewController () {
    MBProgressHUD *loading;
}

@end

@implementation LonginViewController
@synthesize firstName, lastName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view]endEditing:YES];
    //    [self.firstName resignFirstResponder];
}

- (IBAction)loginBtn:(id)sender {
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelText = @"loading...";

    PFQuery *query = [PFQuery queryWithClassName:@"StudentInfo"];
    [query whereKey:@"firstname" equalTo:self.firstName.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        if ([objects count] != 0) {
            [query whereKey:@"lastname" equalTo:self.lastName.text];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if ([objects count] != 0) {
                    
                    //get current user profile
                    userFirstname = self.firstName.text;
                    userLastname = self.lastName.text;
                    team = [[objects valueForKey:@"team"]objectAtIndex:0];
                    
                    //event array getting
                    PFQuery *queryEvent = [PFQuery queryWithClassName:@"Event"];
                    [queryEvent whereKey:@"team1" equalTo:team];
                    [queryEvent findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        event = objects;
                    }];
                    
                    //competition array getting
                    PFQuery *queryComp = [PFQuery queryWithClassName:@"Competition"];
                    [queryComp whereKey:@"team1" equalTo:team];
                    [queryComp findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        currentPeriod = [[objects lastObject]valueForKey:@"period"];
                        competition = objects;
                        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
                        permission = 3;
                        [self.navigationController pushViewController:homeViewController animated:YES];
                    }];
                }
                else {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Login Failed" message:@"Not registered user :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
                    [alert showInView:self.view];
                }
            }];
        }
        else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Login Failed" message:@"Not registered user :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
            [alert showInView:self.view];
        }
        
    }];
}

- (IBAction)signupBtn:(id)sender {
    ProfileViewController *proVCInstance = [self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
    proVCInstance.isFromStartup = TRUE;
    [self.navigationController pushViewController:proVCInstance animated:YES];
}

- (void)getCompetitionArr:(NSString *)currentTeam {
    PFQuery *query = [PFQuery queryWithClassName:@"Competition"];
    [query whereKey:@"team1" equalTo:currentTeam];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        competition = objects;
    }];
}

- (void)getEventArr:(NSString *)currentTeam {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"team1" equalTo:currentTeam];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        competition = objects;
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
