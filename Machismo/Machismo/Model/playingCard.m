//
//  playingCard.m
//  Machismo
//
//  Created by devinxu on 5/24/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "playingCard.h"

@implementation playingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        playingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        }
        else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
        else if((otherCard.rank == self.rank)
                && ([otherCard.suit isEqualToString:self.suit])) {
            score = 8;
        }
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankString = [playingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; //because we redefine setter and getter, so need to create the instance variable for the property yourself.

+ (NSArray *)validSuits {
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}


- (void)setSuit:(NSString *)suit {
    if ([[playingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return  _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9" ,@"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [playingCard maxRank]) {
        _rank = rank;
    }
}

@end
