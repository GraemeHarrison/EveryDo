//
//  DetailViewController.m
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () 

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Todo *toDoObject = (Todo *) self.detailItem;
        
        self.detailTitleLabel.text = toDoObject.title;
        self.detailPriorityLabel.text = toDoObject.priorityNum;
        self.detailDescriptionTextView.text = toDoObject.descript;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm"];
        self.detailDateLabel.text = [dateFormatter stringFromDate:toDoObject.deadline];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
