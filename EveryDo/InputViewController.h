//
//  InputViewController.h
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@protocol InputViewControllerDelegate <NSObject>

-(void)updateInputInfo:(Todo*)newToDoObject;

@end

@interface InputViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *titleInput;
@property (strong, nonatomic) IBOutlet UITextField *priorityInput;
@property (strong, nonatomic) IBOutlet UITextField *descriptionInput;
@property (weak, nonatomic) id <InputViewControllerDelegate> delegate;
@property (strong, nonatomic) Todo *toDoObject;

@end
