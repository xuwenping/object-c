//
//  Card.h
//  Machismo
//
//  Created by devinxu on 5/24/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

// define a properyt type, and set default getter rename to isClosen
@property (nonatomic, getter=isClosen) BOOL closen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
