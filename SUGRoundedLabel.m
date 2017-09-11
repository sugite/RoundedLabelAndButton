//
//  SUGRoundedLabel.m
//  Pods
//
//  Created by sugite on 2017/8/29.
//
//

#import "SUGRoundedLabel.h"

@interface SUGRoundedLabel ()

@property (nonatomic, assign) UIRectCorner corners;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) CGSize layerShadowOffset;
@property (nonatomic, strong) UIColor *layerShadowColor;
@property (nonatomic, assign) CGFloat layerShadowRadius;

@property (nonatomic, strong) CALayer *shadowLayer;

@end

@implementation SUGRoundedLabel

+ (instancetype)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGFloat largestHeight = font.ascender - font.descender;
    if (frame.size.height < largestHeight) {
        frame.size.height = ceil(largestHeight);
    }
    
    SUGRoundedLabel *label = [[self alloc] initWithFrame:frame];
    [label clearBackgroundColor];
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    if (textColor) {
        label.textColor = textColor;
    }
    
    return label;
}

+ (instancetype)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize cornerRadius:(CGFloat)radius
{
    SUGRoundedLabel *label = [SUGRoundedLabel labelWithFrame:frame textColor:textColor fontSize:fontSize];
    [label setAllCornersRadius:radius];
    return label;
}

- (void)setAllCornersRadius:(CGFloat)radius
{
    [self setRoundCorners:UIRectCornerAllCorners radius:radius];
}

- (void)setRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    [self setRoundCorners:corners radius:radius borderColor:nil borderWidth:0];
}

- (void)setRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    self.corners = corners;
    self.radius = radius;
    self.borderColor = borderColor;
    self.borderWidth = borderWidth;
}

- (void)setShadowOffset:(CGSize)shadowOffset shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius
{
    self.layerShadowOffset = shadowOffset;
    self.layerShadowColor = shadowColor;
    self.layerShadowRadius = shadowRadius;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    // UITableViewCell makes label's background clear when highlighted
    if (CGColorGetAlpha(backgroundColor.CGColor) != 0) {
        [super setBackgroundColor:backgroundColor];
    }
}

- (void)clearBackgroundColor
{
    [super setBackgroundColor:UIColor.clearColor];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    
    if (self.text.length == 0 && self.attributedText.length == 0) {
        size.width = 0;
    } else if (self.intriWidth > 0) {
        size.width = self.intriWidth;
    } else {
        size.width += self.padding.left + self.padding.right;
    }
    
    if (self.intriHeight > 0) {
        size.height = self.intriHeight;
    } else {
        size.height += self.padding.top + self.padding.bottom;
    }
    
    return size;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.corners > 0) {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         byRoundingCorners:self.corners
                                                               cornerRadii:CGSizeMake(self.radius, self.radius)];
        borderPath.lineWidth = self.borderWidth;
        [self.borderColor ? : self.backgroundColor setStroke];
        [borderPath stroke];
        
        CAShapeLayer *shape = [[CAShapeLayer alloc] init];
        shape.path = borderPath.CGPath;
        self.layer.mask = shape;
    }
    
    if (self.layerShadowColor) {
        [self.shadowLayer removeFromSuperlayer];
        self.shadowLayer.shadowOpacity = 1;
        self.shadowLayer.shadowOffset = self.layerShadowOffset;
        self.shadowLayer.shadowRadius = self.layerShadowRadius;
        self.shadowLayer.shadowColor = self.layerShadowColor.CGColor;
        self.shadowLayer.shadowPath = [UIBezierPath bezierPathWithRect:self.frame].CGPath;
        
        [self.layer.superlayer insertSublayer:self.shadowLayer below:self.layer];
    }
}

- (CALayer *)shadowLayer
{
    if (!_shadowLayer) {
        _shadowLayer = [CALayer layer];
    }
    return _shadowLayer;
}

- (void)dealloc
{
    [self.shadowLayer removeFromSuperlayer];
}

@end



