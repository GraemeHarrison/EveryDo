//
//  Todo.h
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descript;
@property (nonatomic, strong) NSString *priorityNum;
@property (nonatomic, assign) BOOL isComplete;
@property (nonatomic, strong) NSDate *deadline;

-(instancetype)initWithTitle:(NSString *)title description:(NSString *)descript priorityNum:(NSString*)num;

@end
