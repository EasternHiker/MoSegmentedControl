//
//  MoSegmentedControl.m
//  Demo
//
//  Created by Dmitry Egorov on 8/13/11.
//  Copyright 2011 Mobion. All rights reserved.
//  http://mobitusa.ru
//

#import "MoSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>


@implementation MoSegmentedControl


- (id)initWithItems:(NSArray *)items {
    self = [super init];
    
    if (self) {
        
        _numberOfSegments = [items count];
        _buttons = [[NSMutableArray alloc] initWithCapacity:_numberOfSegments];
        float cornerRadius = 10.f;
        float borderWidth = 1.f;
        
        self.autoresizesSubviews = YES;
        
        self.frame = CGRectMake(0, 0, 240, 30);
        
        float totalWidth = self.frame.size.width;
        int visibleButtonWidth = totalWidth / _numberOfSegments;
        float height = self.frame.size.height;
        
        UIImage *normalBgImage = [UIImage imageNamed:@"normalBg.png"];
        UIImage *selectedBgImage = [UIImage imageNamed:@"selectedBg.png"];
        UIColor *borderColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.];
        
        
        for (int i = 0; i < _numberOfSegments; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [_buttons addObject:button];
            
            NSObject *content = [items objectAtIndex:i];
            if ([content isKindOfClass:[NSString class]]) {
                [button setTitle:(NSString *)content forState:UIControlStateNormal];
            }
            
            int w = visibleButtonWidth;
            int x = visibleButtonWidth * i;
            
            BOOL buttonIsLeftmost = i == 0;
            BOOL buttonIsRightmost = i == _numberOfSegments - 1;
            
            if (buttonIsLeftmost) {
                w += cornerRadius;
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, cornerRadius);
                
            } else if (buttonIsRightmost) {
                w += cornerRadius;
                x -= cornerRadius;
                button.titleEdgeInsets = UIEdgeInsetsMake(0, cornerRadius, 0, 0);
            } else {
            
                if (_numberOfSegments >= 4 && i >= 1 && i <= _numberOfSegments - 3) {
                    //to avoid duplication of borders
                    w += borderWidth;
                }
            }
            
            button.frame = CGRectMake(x, 0, w, height);
            button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            BOOL roundedCorner = buttonIsLeftmost || buttonIsRightmost;
            if (roundedCorner) {
                [button.layer setCornerRadius:cornerRadius];
                [button.layer setMasksToBounds:YES];
            }
            
            [button.layer setBorderWidth:borderWidth];
            [button.layer setBorderColor:borderColor.CGColor];
            
            [button setBackgroundImage:normalBgImage forState:UIControlStateNormal];
            [button setBackgroundImage:selectedBgImage forState:UIControlStateSelected];
            
            [button addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            if (buttonIsRightmost && _numberOfSegments > 2) {
                [self insertSubview:button atIndex:i-1];
            } else {
                [self addSubview:button];
            }
        }
        
    }
    return self;
}

- (void) dealloc {
    [_buttons release];
    [super dealloc];
}

#pragma mark - public

- (BOOL) isSegmentSelected:(int)segment {
    UIButton *button = [_buttons objectAtIndex:segment];
    return button.selected;
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment {
    if (segment >= _numberOfSegments) {
        return;
    }
    
    UIButton *button = [_buttons objectAtIndex:segment];
    [button setTitle:title forState:UIControlStateNormal];
}

- (void) makeSegment:(int)segment selected:(BOOL)selected {
    UIButton *button = [_buttons objectAtIndex:segment];
    if (button.selected != selected) {
        button.selected = selected;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark -

- (void) updateButton:(UIButton *)button toState:(UIControlState) state {
    switch (button.state) {
        case UIControlStateNormal:
            button.backgroundColor = [UIColor whiteColor];
            break;
        case UIControlStateHighlighted:
            button.backgroundColor = [UIColor lightGrayColor];
            break;
        case UIControlStateSelected:
            button.backgroundColor = [UIColor darkGrayColor];
            break;
            
        default:
            break;
    }
}

- (void) buttonDidTouchUpInside:(UIButton *)button {
    button.selected = !button.selected;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end
