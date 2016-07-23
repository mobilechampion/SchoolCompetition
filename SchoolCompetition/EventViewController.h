//
//  EventViewController.h
//  SchoolCompetition
//
//  Created by gold on 3/28/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHDropDownControlView.h"
#import "AJDropDownPicker.h"

@interface EventViewController : UIViewController<LHDropDownControlViewDelegate, AJDropDownPickerDelegte> {
    LHDropDownControlView *dropdown;
}

@property (weak, nonatomic) IBOutlet UITextField *eventText;

@property (weak, nonatomic) IBOutlet UIButton *teamSelect;

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
