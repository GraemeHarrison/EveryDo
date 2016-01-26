//
//  ToDoCell.h
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priorityLabel;

@end
