//
//  ViewController.m
//  FlexboxKitDemo
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#include <stdlib.h>
#import "UIColor+Demo.h"
#import "GridDemoViewController.h"
@import FlexboxKit;

@interface GridDemoViewController ()

@property (nonatomic, strong) UIView *firstRow, *secondRow;
@property (nonatomic, strong) NSArray *firstRowViews, *secondRowViews;

@end

@implementation GridDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the flexbox containers
    FLEXBOXContainerView *container = [[FLEXBOXContainerView alloc] initWithFrame:self.view.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    container.backgroundColor = [UIColor darkGrayColor];
    container.flexDirection = FLEXBOXFlexDirectionColumn;
    
    self.firstRow = [[UIView alloc] initWithFrame:self.view.bounds];
    self.firstRow.layer.borderColor = UIColor.purpleColor.CGColor;
    self.firstRow.layer.borderWidth = 4;
    self.firstRow.flexContainer = YES;
    
    self.secondRow = [[UIView alloc] initWithFrame:self.view.bounds];
    self.secondRow.layer.borderColor = UIColor.purpleColor.CGColor;
    self.secondRow.layer.borderWidth = 4;
    self.secondRow.flexContainer = YES;

    self.firstRowViews = [self createFirstRowViews];
    self.secondRowViews = [self createSecondRowViews];
    
    [self.view addSubview:container];
    [container addSubview:self.firstRow];
    [container addSubview:self.secondRow];

    for (UIView *v in self.firstRowViews)
        [self.firstRow addSubview:v];
    
    for (UIView *v in self.secondRowViews)
        [self.secondRow addSubview:v];
    
    [self layout:0];
}

- (void)didPressButton:(UIButton*)sender
{
    [self layout:sender.tag];
}

#pragma mark - Different layouts

- (void)layout:(NSInteger)index
{
    for (FLEXBOXContainerView *c in @[self.firstRow, self.secondRow]) {
        c.flexAlignItems = FLEXBOXAlignmentCenter;
        c.flexDirection = FLEXBOXFlexDirectionRow;
        CGFloat containerGut = 20;
        c.flexMargin = (UIEdgeInsets){containerGut, containerGut, containerGut, containerGut};;
    }
    
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:self.firstRowViews];
    [subviews addObjectsFromArray:self.secondRowViews];
    
    for (UIView *v in subviews) {
        CGFloat gut = 4;
        v.flexMargin = (UIEdgeInsets){gut, gut, gut, gut};
        v.flexPadding = (UIEdgeInsets){gut, gut, gut, gut};
    }

    [self.secondRowViews[0] setFlex:0];
    [self.secondRowViews[0] setFlexFixedSize:(CGSize){120,60}];

    switch (index) {

        case 0: {
            [self.firstRowViews[0] setFlex:1.0/2.0];
            [self.firstRowViews[1] setFlex:1.0/6.0];
            [self.firstRowViews[2] setFlex:1.0/6.0];
            [self.firstRowViews[3] setFlex:1.0/6.0];
            break;
        }
            
        case 1: {
            [self.firstRowViews[0] setFlex:1.0/2.0];
            [self.firstRowViews[1] setFlex:1.0/2.0];
            [self.firstRowViews[2] setFlex:1.0/8.0];
            [self.firstRowViews[3] setFlex:1.0/8.0];
            break;
        }
            
        case 2: {
            [self.firstRowViews[0] setFlex:0.75/4.0];
            [self.firstRowViews[1] setFlex:0.75/4.0];
            [self.firstRowViews[2] setFlex:0.75/4.0];
            [self.firstRowViews[3] setFlex:0];
            break;
        }
            
        case 3: {
            [self.firstRowViews[0] setFlex:1];
            [self.firstRowViews[1] setFlex:1];
            [self.firstRowViews[2] setFlex:1];
            [self.firstRowViews[3] setFlex:1];
            break;
        }
            
        default:
            break;
    }
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        [[self.firstRow superview] flexLayoutSubviews];
    } completion:^(BOOL finished) { }];
}

#pragma mark - Test view (No layout logic)

// creates some test views
- (NSArray*)createFirstRowViews
{
    NSArray *labels = @[@"1", @"2", @"3", @"4"];
    
    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[UIColor.tomatoColor, UIColor.steelBlueColor][i%2]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = i;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}

- (NSArray*)createSecondRowViews
{
    NSArray *labels = @[@"A fixed size item"];

    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[UIColor.tomatoColor, UIColor.steelBlueColor][i%2]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = 4;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}

@end
