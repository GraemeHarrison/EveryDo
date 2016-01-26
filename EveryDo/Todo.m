//
//  Todo.m
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)descript priorityNum:(NSString*)num
{
    self = [super init];
    if (self) {
        _title = title;
        _descript = descript;
        _priorityNum = num;
        _isComplete = NO;
    }
    return self;
}

@end
