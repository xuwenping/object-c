//
//  cardMathcingGame.m
//  Machismo
//
//  Created by devinxu on 5/26/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "cardMathcingGame.h"

@interface cardMathcingGame()
@property (nonatomic, readwrite) NSInteger socre;
@property (strong, nonatomic) NSMutableArray *cards; // of card
@end

@implementation cardMathcingGame

// lazy instantiation
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {

    self = [super init]; // super's designed initialize
    
    if (self) {
        for (int i = 0; i < count; ++i) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BOUNS = 4;
static const int COST_TO_CHOOSEN = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card * card = [self cardAtIndex:index];
    
    // we will allow unmatched cards to be chosen
    // (i.e. once a card is matched, it's out of the game)
    if (!card.isMatched) {
        if (card.isClosen) {
            card.closen = NO;
        }
        else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isClosen && !otherCard.isMatched) {
                    int matchSocre = [card match:@[otherCard]];
                    if (matchSocre) {
                        self.socre += matchSocre * MATCH_BOUNS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else {
                        self.socre -= MISMATCH_PENALTY;
                        otherCard.closen = NO;
                    }
                    break;
                }
            }
            self.socre -= COST_TO_CHOOSEN;
            card.closen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end
