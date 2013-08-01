//
//  MoSegmentedControl.h
//  Demo
//
//  Created by Dmitry Egorov on 8/13/11.
//  Copyright 2011 Mobion. All rights reserved.
//  http://mobitusa.ru
//

#import <Foundation/Foundation.h>


@interface MoSegmentedControl : UIControl


@property (nonatomic, readonly) int numberOfSegments;

- (id)initWithItems:(NSArray *)items;
- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;
- (BOOL) isSegmentSelected:(int)segment;
- (void) makeSegment:(int)segment selected:(BOOL)selected;

- (id)initWithCoder:(NSCoder *)coder;

@end
