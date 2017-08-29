//
//  SUGRoundedButton.m
//  Pods
//
//  Created by sugite on 2017/8/29.
//
//

#import "SUGRoundedButton.h"

@interface SUGRoundedButton ()

@property (nonatomic, assign) UIRectCorner corners;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@end

@implementation SUGRoundedButton

+ (instancetype)buttonWithFrame:(CGRect)frame image:(UIImage *)image hitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    SUGRoundedButton *button = [[self alloc] initWithFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    button.hitTestEdgeInsets = hitTestEdgeInsets;
    
    return button;
}

- (void)setRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    self.corners = corners;
    self.radius = radius;
    self.borderColor = borderColor;
    self.borderWidth = borderWidth;
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    _hitTestEdgeInsets.top      = -hitTestEdgeInsets.top;
    _hitTestEdgeInsets.left     = -hitTestEdgeInsets.left;
    _hitTestEdgeInsets.bottom   = -hitTestEdgeInsets.bottom;
    _hitTestEdgeInsets.right    = -hitTestEdgeInsets.right;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = UIEdgeInsetsInsetRect(self.bounds, self.hitTestEdgeInsets);
    return CGRectContainsPoint(rect, point);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.corners == 0) {
        return;
    }
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:self.corners
                                                           cornerRadii:CGSizeMake(self.radius, self.radius)];
    borderPath.lineWidth = self.borderWidth;
    [self.borderColor ? : self.backgroundColor setStroke];
    [borderPath stroke];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:borderPath.CGPath];
    self.layer.mask = shape;
}

@end

