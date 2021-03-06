//
//  ViewController.m
//  Machismo
//
//  Created by devinxu on 5/24/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "ViewController.h"
#import "cardMathcingGame.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@property (nonatomic) int filpCount;

@property (strong,nonatomic) Deck *deck;

@property (strong, nonatomic) cardMathcingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation ViewController

- (cardMathcingGame *)game {
    if (!_game) {
        _game = [[cardMathcingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    
    return _game;
}

- (Deck *)deck {
    if (!_deck) {
        _deck = [self createDeck];
    }
    
    return _deck;
}

// abstact
- (Deck *)createDeck {
    return nil;
}


- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons
                             indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setTitleColor:[self titleColorForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
        [self titleForCard:card];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"score %ld", (long)self.game.socre];
    
}

- (void)tipsForCard:(Card *)card {
    if (card.isChosen) {
        self.tipsLabel.text = [NSString stringWithFormat:@"Tips: you chosen card is %@", card.contents];
    }
}

- (UIColor *)titleColorForCard:(Card *)card {
    UIColor * colorForCard = [UIColor blackColor];
    
    if (card.isChosen) {
        NSString *cardContents = card.contents;
        if ([cardContents containsString:@"♠︎"] || [cardContents containsString:@"♣︎"]) {
            colorForCard = [UIColor blackColor];
        }
        else {
            colorForCard = [UIColor redColor];
        }
    }
    
    return colorForCard;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents :@"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardBefore" : @"cardBack"];
}

@end
