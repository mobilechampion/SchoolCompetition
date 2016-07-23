//
//  ProfileViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/26/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "MBProgressHUD.h"
@interface ProfileViewController : UIViewController<UITextFieldDelegate, NIDropDownDelegate, MBProgressHUDDelegate> {
    NIDropDown *dropdown;
}

@property (nonatomic, strong) NSString *firstName1;
@property (nonatomic, strong) NSString *lastName1;
@property (nonatomic, assign) BOOL isFromStartup;

@property (weak, nonatomic) IBOutlet UIImageView *profileAvatar;

@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;

@property (weak, nonatomic) IBOutlet UIButton *teamSelect;

@property (weak, nonatomic) IBOutlet UIButton *createBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end
