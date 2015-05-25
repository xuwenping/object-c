//
//  playingCardDeck.m
//  Machismo
//
//  Created by devinxu on 5/24/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "playingCardDeck.h"
#import "playingCard.h"

@implementation playingCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString *suit in [playingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [playingCard maxRank]; rank++) {
                playingCard *card = [[playingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}


@end
