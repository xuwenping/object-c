//
//  PlayingCardView.m
//  SuperCard
//
//  Created by devinxu on 6/14/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "PlayingCardView.h"

@interface  PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

#pragma mark - properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor {
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit {
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceup:(BOOL)faceup {
    _faceup = faceup;
    [self setNeedsDisplay];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor = gesture.scale;
        gesture.scale = 1.0;
    }
}

#pragma mark - Drawing

#define CONNER_FONT_STANDARD_HEIGHT 180.0
#define CONNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {
    return self.bounds.size.height / CONNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
    return CONNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
    return [self cornerRadius] / 3.0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.faceup) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0 -self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        }
        else {
            [self drawPips];
        }
        
        [self drawCorners];
    }
    else {
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
    
}

- (void)drawPips {
    
}

- (NSString *)rankAsString {
    return @[@"?", @"A", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9" ,@"10", @"J", @"Q", @"K"][self.rank];
}

- (void)drawCorners {
    NSMutableParagraphStyle *paragraphStyple = [[NSMutableParagraphStyle alloc] init];
    paragraphStyple.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSFontAttributeName: cornerFont, NSParagraphStyleAttributeName: paragraphStyple}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}


#pragma mark - Initialization

- (void)setup {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
}


@end
