//
//  DropitBehavior.h
//  Dropit
//
//  Created by devinxu on 6/18/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
