//
//  ViewController.m
//  Machismo
//
//  Created by devinxu on 5/24/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "ViewController.h"
#import "playingCardDeck.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *filpsLabel;

@property (nonatomic) int filpCount;

@property (strong,nonatomic) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck {
    if (!_deck) {
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (Deck *)createDeck {
    return [[playingCardDeck alloc] init];
}

- (void)setFilpCount:(int)filpCount {
    _filpCount = filpCount;
    self.filpsLabel.text = [NSString stringWithFormat:@"Filps: %d", self.filpCount];
    NSLog(@"filpCount = %d", self.filpCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        UIImage *cardImage = [UIImage imageNamed:@"cardBack"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.filpCount++;
    }
    else {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            UIImage *cardImage = [UIImage imageNamed:@"cardBefore"];
            [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
            self.filpCount++;
        }
    }
}

@end
