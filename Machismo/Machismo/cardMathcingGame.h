//
//  cardMathcingGame.h
//  Machismo
//
//  Created by devinxu on 5/26/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface cardMathcingGame : NSObject

// designed initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger socre;


@end
