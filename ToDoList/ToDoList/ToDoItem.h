//
//  ToDoItem.h
//  ToDoList
//
//  Created by devinxu on 5/23/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;
@property NSDate *completionDate;

- (void)markAsCompleted:(BOOL)isCompleted;

@end
