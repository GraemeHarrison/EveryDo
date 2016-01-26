//
//  InputViewController.m
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController () <UITextFieldDelegate>

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleInput becomeFirstResponder];
    self.titleInput.delegate = self;
    self.priorityInput.delegate = self;
    self.descriptionInput.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Change functionality of return key based on who is the first responder
    if (textField == self.titleInput) {
        [self.priorityInput becomeFirstResponder];
    } else if (textField == self.priorityInput) {
        [self.descriptionInput becomeFirstResponder];
    } else if (textField == self.descriptionInput){
        [self.descriptionInput resignFirstResponder];
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Dismiss the keyboard whenever we touch outside the textfields by telling our textfields to give up first responder status
    [self.titleInput resignFirstResponder];
    [self.priorityInput resignFirstResponder];
    [self.descriptionInput resignFirstResponder];
}

- (IBAction)doneButton:(UIButton *)sender {
    self.toDoObject =[[Todo alloc]init];
    self.toDoObject.title = self.titleInput.text;
    self.toDoObject.priorityNum = self.priorityInput.text;
    self.toDoObject.descript = self.descriptionInput.text;
    [self.delegate updateInputInfo:self.toDoObject];
    [self dismissViewControllerAnimated:YES completion:nil];
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
