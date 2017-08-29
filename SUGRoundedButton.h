//
//  SUGRoundedButton.h
//  Pods
//
//  Created by sugite on 2017/8/29.
//
//

@interface SUGRoundedButton : UIButton

// enlarge touch area, margin is positive, padding is negative
@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

// convenient for creating a button like "close"
+ (instancetype)buttonWithFrame:(CGRect)frame
                          image:(UIImage *)image
              hitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets;

// set round corner & border
- (void)setRoundCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat)borderWidth;

@end
