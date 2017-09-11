//
//  SUGRoundedLabel.h
//  Pods
//
//  Created by sugite on 2017/8/29.
//
//

@interface SUGRoundedLabel : UILabel

// only support :  left == right && top == bottom
@property (nonatomic, assign) UIEdgeInsets padding;

// fix size
@property (nonatomic, assign) CGFloat intriWidth;
@property (nonatomic, assign) CGFloat intriHeight;

// convenience for creating label
+ (instancetype)labelWithFrame:(CGRect)frame
                     textColor:(UIColor *)textColor
                      fontSize:(CGFloat)fontSize;

+ (instancetype)labelWithFrame:(CGRect)frame
                     textColor:(UIColor *)textColor
                      fontSize:(CGFloat)fontSize
                  cornerRadius:(CGFloat)radius;

// set radius with all corners
- (void)setAllCornersRadius:(CGFloat)radius;

// set round corner
- (void)setRoundCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius;

// set round corner & border
- (void)setRoundCorners:(UIRectCorner)corners
                 radius:(CGFloat)radius
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat)borderWidth;

// set shadow
- (void)setShadowOffset:(CGSize)shadowOffset
            shadowColor:(UIColor *)shadowColor
           shadowRadius:(CGFloat)shadowRadius;

// clear backgroundcolor by setter has been shielded
- (void)clearBackgroundColor;

@end
