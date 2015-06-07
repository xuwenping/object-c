//
//  playCardGameViewController.m
//  Machismo
//
//  Created by devinxu on 6/7/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "playCardGameViewController.h"
#import "playingCardDeck.h"

@interface playCardGameViewController ()

@end

@implementation playCardGameViewController

- (Deck *)createDeck {
    return [[playingCardDeck alloc] init];
}

@end
