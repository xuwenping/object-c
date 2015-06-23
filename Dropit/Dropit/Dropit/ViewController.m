//
//  ViewController.m
//  Dropit
//
//  Created by devinxu on 6/18/15.
//  Copyright (c) 2015 devinxu. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"

@interface ViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DropitBehavior *dropitBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIView *dropingView;
@end

@implementation ViewController

static const CGSize DROP_SIZE = { 40, 40};

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    
    return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    [self removeCompletedRows];
}

// need to understand the logic
- (BOOL)removeCompletedRows {
    NSMutableArray  *dropToRemove = [[NSMutableArray alloc] init];
    CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height / 2;
    for (; y > 0; y -= DROP_SIZE.height) {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (CGFloat x = DROP_SIZE.width/2; x <= self.gameView.bounds.size.width - DROP_SIZE.width/2 ; x += DROP_SIZE.width) {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:nil];
            if (hitView.superview == self.gameView) {
                [dropsFound addObject:hitView];
            }
            else {
                rowIsComplete = NO;
                break;
            }
        }
        
        if (![dropsFound count]) {
            break;
        }
        
        if (rowIsComplete) {
            [dropToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if ([dropToRemove count]) {
        for (UIView *drop in dropToRemove) {
            [self.dropitBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropToRemove];
    }
    
    return NO;
}

- (void)animateRemovingDrops:(NSArray *)dropToRemove {
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *drop in dropToRemove) {
                             int x = (arc4random()%(int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width*2;
                             int y = self.gameView.bounds.size.height;
                             drop.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished) {
                         [dropToRemove makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
                     }];
}

- (DropitBehavior *)dropitBehavior {
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    
    return _dropitBehavior;
}


- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (void)drop {
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    self.dropingView = dropView;
    
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    
    [self.dropitBehavior addItem:dropView];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self attachDropingViewToPoint:gesturePoint];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        self.attachment.anchorPoint = gesturePoint;
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.attachment];
        self.gameView.path = nil;
    }
}

- (void)attachDropingViewToPoint:(CGPoint)anchorPoint {
    if (self.dropingView) {
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.dropingView attachedToAnchor:anchorPoint];
        UIView *tempDropingView = self.dropingView;
        __weak ViewController *weakSelf = self;
        self.attachment.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachment.anchorPoint];
            [path addLineToPoint:tempDropingView.center];
            weakSelf.gameView.path = path;
        };
        self.dropingView = nil;
        [self.animator addBehavior:self.attachment];
    }
}

- (UIColor *)randomColor {
    switch ((arc4random()%5)) {
        case 0:
            return [UIColor greenColor];
        case 1:
            return [UIColor blueColor];
        case 2:
            return [UIColor orangeColor];
        case 3:
            return [UIColor redColor];
        case 4:
            return [UIColor purpleColor];

    }
    
    return [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
