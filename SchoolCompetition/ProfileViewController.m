//
//  ProfileViewController.m
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "HomeViewController.h"
#import "LonginViewController.h"
#import "CustomAlert.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstName.delegate = self;
    self.lastName.delegate = self;

    self.firstName.text = userFirstname;
    self.lastName.text = userLastname;
    self.teamSelect.titleLabel.text = team;
    NSLog(@"first name = %@", self.firstName.text);
    NSLog(@"last name = %@", self.lastName.text);
    
    self.profileAvatar.layer.cornerRadius = self.profileAvatar.frame.size.height/2;
    self.profileAvatar.layer.masksToBounds = YES;
    self.profileAvatar.layer.borderWidth = 0;
    
    
    if (self.isFromStartup) {
        self.editBtn.enabled = NO;
        self.createBtn.enabled = NO;
        [self.editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.profileAvatar.image = [UIImage imageNamed:@"avatar-empty.gif"];
    }
    else{
        self.createBtn.enabled = NO;
        self.firstName.enabled = NO;
        self.lastName.enabled = NO;
        [self.createBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view]endEditing:YES];
//    [self.firstName resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    self.createBtn.enabled = YES;
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification {

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];
    
    [self.view setFrame:CGRectMake(0, -100, 375, 667)];
    
    [UIView commitAnimations];
    
}

- (void)keyboardDidHide:(NSNotification *)notification {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];
    
    [self.view setFrame:CGRectMake(0, 0, 375, 667)];
    
    [UIView commitAnimations];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)editBtn:(id)sender {
    if ([self.editBtn.titleLabel.text isEqual:@"Edit"]) {
        self.firstName.enabled = YES;
        self.lastName.enabled = YES;
        [self.editBtn setTitle:@"Save" forState:UIControlStateNormal];
    }
    else if ([self.editBtn.titleLabel.text isEqual:@"Save"]) {
        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"" message:@"Editing Success :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
        [alert showInView:self.view];
    }
}

- (IBAction)createBtn:(id)sender {
    if (![self.firstName.text isEqual:@""]&&![self.lastName.text isEqual:@""]) {
       
        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Congratulation" message:@"Welcome to register :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
        [alert showInView:self.view];
        wait(10000);
        
        PFObject *studentInfo = [PFObject objectWithClassName:@"StudentInfo"];
        studentInfo[@"firstname"] = self.firstName.text;
        studentInfo[@"lastname"] = self.lastName.text;
        studentInfo[@"team"] = self.teamSelect.titleLabel.text;
        [studentInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"success");
            }
            else{
                NSLog(@"fail");
            }
        }];
        
        LonginViewController *loginVCInstance = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self.navigationController pushViewController:loginVCInstance animated:YES];

    }
    else {
        CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"Warning" message:@"Please input full name :)" delegate:self cancelButtonTitle:@"OK" otherButtonTitle:@""];
        [alert showInView:self.view];
    }
}

- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)teamselectBtn:(id)sender {
    NSArray *arr = [[NSArray alloc]init];
    arr = [NSArray arrayWithObjects:@"Cereal Killaz",@"Gators",@"Gym Class Crew",@"Lob City",@"Math Sucks",@"Monkey Time",@"Pandas",@"Pirates", nil];
    NSArray *arrImg = [[NSArray alloc]init];
    arrImg = [NSArray arrayWithObjects:[UIImage imageNamed:@"Cereal Killaz.png"], [UIImage imageNamed:@"Gators.png"], [UIImage imageNamed:@"Gym Class Crew.png"], [UIImage imageNamed:@"Lob City.png"], [UIImage imageNamed:@"Math Sucks.png"], [UIImage imageNamed:@"Monkey Time.png"], [UIImage imageNamed:@"Pandas.png"], [UIImage imageNamed:@"Pirates.png"], nil];

   if (dropdown == nil) {
        CGFloat f = 150;
        dropdown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImg :@"down"] ;
        dropdown.delegate = self;
    }
    else {
        [dropdown hideDropDown:sender];
        dropdown = nil;
    }
}

- (void)niDropDownDelegateMethod:(NIDropDown *)sender {
    dropdown = nil;
}
@end
