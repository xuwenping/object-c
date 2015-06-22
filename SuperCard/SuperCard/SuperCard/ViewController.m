//
//  ViewController.m
//  SuperCard
//
//  Created by devinxu on 6/11/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "playingCard.h"
#import "playingCardDeck.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;


@property (strong, nonatomic) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck  {
    if (!_deck) {
        _deck = [[playingCardDeck alloc] init];
    }
    return _deck;
}

- (void)drawRandomPlayingCard {
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[playingCard class]]) {
        playingCard *pCard = (playingCard *)card;
        self.playingCardView.rank = pCard.rank;
        self.playingCardView.suit = pCard.suit;
    }
}

- (void)drawRandomPlayingCard:(PlayingCardView *)pCardView {
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[playingCard class]]) {
        playingCard *pCard = (playingCard *)card;
        pCardView.rank = pCard.rank;
        pCardView.suit = pCard.suit;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    PlayingCardView *pCardView = (PlayingCardView *)sender.view;
    pCardView.faceup = !pCardView.faceup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.playingCardView.suit = @"♥️";
//    self.playingCardView.rank = 13;
//    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
    
    [self initilizationCardUI];
}

- (void)initilizationCardUI {

    [self drawRandomPlayingCard:self.playingCardView];

}

@end
