//
//  ToDoItem.m
//  ToDoList
//
//  Created by devinxu on 5/23/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (void)markAsCompleted:(BOOL)isCompleted {
    self.completed = isCompleted;
    [self setCompletionDate];
}

- (void)setCompletionDate {
    if (self.completed) {
        self.completionDate = [NSDate date];
    }
    else {
        self.completionDate = nil;
    }
}

@end
