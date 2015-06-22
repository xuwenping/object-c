//
//  PlayingCardView.h
//  SuperCard
//
//  Created by devinxu on 6/14/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceup;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
