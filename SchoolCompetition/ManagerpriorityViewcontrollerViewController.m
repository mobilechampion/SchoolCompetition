//
//  ManagerpriorityViewcontrollerViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "AppDelegate.h"
#import "ManagerpriorityViewcontrollerViewController.h"
#import "HomeViewController.h"
#import "CustomAlert.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface ManagerpriorityViewcontrollerViewController () {
    MBProgressHUD *loading;
}

@end

@implementation ManagerpriorityViewcontrollerViewController

@synthesize priorityPsw;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view]endEditing:YES];
    //    [self.firstName resignFirstResponder];
}
- (IBAction)managerConfirm:(id)sender {
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelText = @"loading...";

    if ([self.priorityPsw.text isEqual:@"manager"]) {
        team = @"Gym Class Crew";
        
        //event array getting
        PFQuery *queryEvent = [PFQuery queryWithClassName:@"Event"];
        [queryEvent whereKey:@"team1" equalTo:team];
        [queryEvent findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            event = objects;
        }];
        
        //competition array etting
        PFQuery *query = [PFQuery queryWithClassName:@"Competition"];
        [query whereKey:@"team1" equalTo:team];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] != 0) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                currentPeriod = [[objects lastObject]valueForKey:@"period"];
            }
            competition = objects;
            HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
            permission = 0;
            [self.navigationController pushViewController:homeViewController animated:YES];
        }];
    }
    else{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Warning" message:@"Please Confirm Manager Priority :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
        [alert showInView:self.view];
    }
//    HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
//    homeViewController.permission = 0;
//    [self.navigationController pushViewController:homeViewController animated:YES];
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
