//
//  TextStatsViewController.m
//  Attribute
//
//  Created by devinxu on 6/7/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharacterLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacterLabel;
@end

@implementation TextStatsViewController

- (void)updateUI {
    self.colorfulCharacterLabel.text = [NSString stringWithFormat:@"%d colorful characters", (int)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharacterLabel.text = [NSString stringWithFormat:@"%d outlined characters", (int)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    
    // if on the onscreen, and someone set the text I'm supposed to analyze
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttribute: (NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName
                                         atIndex:index
                                  effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)range.location + (int)range.length;
        }
        else {
            index++;
        }
    }
    
    return characters;
}

@end
