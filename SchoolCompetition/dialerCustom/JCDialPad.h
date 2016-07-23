
@class JCDialPad, JCPadButton;
#import <UIKit/UIKit.h>
@protocol JCDialPadDelegate <NSObject>

@optional
- (BOOL)dialPad:(JCDialPad *)dialPad shouldInsertText:(NSString *)text forButtonPress:(JCPadButton *)button;
- (BOOL)dialPad:(JCDialPad *)dialPad shouldInsertText:(NSString *)text forLongButtonPress:(JCPadButton *)button;

@end

@interface JCDialPad : UIView

@property (nonatomic, strong) UIColor *mainColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, copy) NSString *rawText;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic) BOOL formatTextToPhoneNumber;

@property (nonatomic, strong) UIView* backgroundView;
@property (assign, nonatomic) BOOL showDeleteButton;

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UITextField *digitsTextField;

@property (weak, nonatomic) id<JCDialPadDelegate> delegate;

/**
 Standard cell phone buttons: 0-9, # and * buttons
 */
+ (NSArray *)defaultButtons;

- (id)initWithFrame:(CGRect)frame buttons:(NSArray *)buttons;

@end