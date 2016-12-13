//
//  WENDesktopView.m
//  ADViewDemo
//
//  Created by HS001 on 2016/12/12.
//  Copyright © 2016年 ISNC. All rights reserved.
//

#import "WENDesktopView.h"

@interface WENDesktopView()<UIGestureRecognizerDelegate>

@property(strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property(strong, nonatomic) CAShapeLayer *lineLayer2 ;


@end
@implementation WENDesktopView

- (id)init{
    self = [super init];
    if (self){
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if( self.showDelBtn){
        [self drawSuperid_ad_close];
    }
}

#pragma mark -

- (void)commonInit{
    self.showDelBtn = YES;
    
    self.widthToSuperView = 0.64;
    self.adRatio = 10/7.0;
    self.delIconWidth = 21;
    self.delIconDelt = 23;
    
    self.closeBtnColor = [UIColor whiteColor];
    
    //MaskView
    self.maskView = [[UIView alloc] init];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setAdView:(UIView *)adView{
    if(_adView == adView){
        return;
    }
    _adView = adView;
    if(self.superview ){
        [self updateADView ];
    }
    [self addTapGestureForMask];
}


- (void)showInView:(UIView *)view image: (UIImage *)image{
    //图片设置
    [self addConstruction:view image:image];
    //添加关闭按钮的动画
    [self addCloseBtnWithAnimation];
    
}
//图片设置
-(void)addConstruction:(UIView*)view  image: (UIImage *)image{
    if (self.adView == nil || NO == [self.adView isKindOfClass:[UIView class]]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        imageView.backgroundColor = [UIColor blackColor];
        self.adView = imageView;
    }
    self.adView.layer.cornerRadius = 5 ;
    self.adView.clipsToBounds = YES ;
    
    [view addSubview:self];
    [self addConstraintTo:view for:self edge:UIEdgeInsetsZero];
    
    [self addSubview:self.maskView];
    [self addConstraintTo:self for:self.maskView edge:UIEdgeInsetsZero];
    
    [self addSubview:self.adView];
    [self updateADView ];
    
    [self addTapGestureForMask];
    
}

//添加关闭按钮的动画
-(void)addCloseBtnWithAnimation{
    [self drawSuperid_ad_close];
}

-(UIBezierPath *)getYuanBezierPathFor:(CGRect)frame path:(UIBezierPath *)path{
  
    CGFloat radis = MIN(frame.size.width , frame.size.height)/2;
    CGPoint origin = CGPointMake(frame.origin.x + radis, frame.origin.y + radis);
    
    CGFloat startAngle ,endAngle;
    if(frame.size.width > frame.size.height ){
        startAngle = 0;
        endAngle = 2 * M_PI;
    }else{
        startAngle = M_PI_2;
        endAngle = 5 * M_PI_2;
        
    }
    
    UIBezierPath* yuanPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radis startAngle:startAngle endAngle:endAngle clockwise:YES];
    yuanPath.lineWidth = 2;
    yuanPath.miterLimit = 4;
    
    if(path){
        [path appendPath:yuanPath];
        return path;
    }
    return yuanPath;
    
}
//动画
- (void)drawSuperid_ad_close{
    
    CGFloat w = self.delIconWidth;
    CGFloat deltTop = self.delIconDelt;
    
    CGRect frame = CGRectMake(CGRectGetMaxX(self.adView.frame) - w, CGRectGetMinY(self.adView.frame) - w - deltTop, w,  w + deltTop);
    
    CAShapeLayer *lineLayer2;
    if(_lineLayer2){
        lineLayer2 = _lineLayer2;
        
    }else{
        lineLayer2 = [ CAShapeLayer layer ];
        _lineLayer2 = lineLayer2;
    }
    
    lineLayer2.frame = frame;
    lineLayer2.path = [self getLastBezierPathFor:lineLayer2.bounds path: [self getYuanBezierPathFor :lineLayer2.bounds path:[self getDeleteBezierPathFor:lineLayer2.bounds path:nil]]]. CGPath ;
    
    lineLayer2. strokeColor = self.closeBtnColor. CGColor ;
    
    //第三，动画
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0 ;
    ani.toValue = @1 ;
    ani.duration = 2 ;
    
    [lineLayer2 addAnimation :ani forKey : NSStringFromSelector ( @selector (strokeEnd))];
    
    [self.maskView. layer addSublayer :lineLayer2];
    
}


- (void)addConstraintTo:(UIView *)superView for:(UIView  *)subview edge:(UIEdgeInsets)edge{
    
    UIView *supview =  superView;
    [supview addSubview:subview];
    
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leftC = [NSLayoutConstraint constraintWithItem:subview
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:supview
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:edge.left];
    
    NSLayoutConstraint *rightC = [NSLayoutConstraint constraintWithItem:subview
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:supview
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1
                                                               constant:edge.right];
    
    NSLayoutConstraint *topC = [NSLayoutConstraint constraintWithItem:subview
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:supview
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:edge.top];
    
    NSLayoutConstraint *bottomC = [NSLayoutConstraint constraintWithItem:subview
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:supview
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1
                                                                constant:edge.bottom];
    
    
    bottomC.active = YES;
    topC.active = YES;
    leftC.active = YES;
    rightC.active = YES;
    
    ///约束
    [supview addConstraints:@[ topC,leftC,rightC,bottomC ]];
    
}

- (void)updateADView {
    UIView *subview = self.adView;
    UIView *supview = self;
    
    [supview addSubview:subview];
    
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    
    if(self.widthToSuperView != 0 ){
        NSLayoutConstraint *wC = [NSLayoutConstraint constraintWithItem:subview
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:supview
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:self.widthToSuperView
                                                               constant:0];
        wC.active = YES;
        //约束
        [supview addConstraints:@[wC]];
    }else{
        //不约束
    }
    
    NSLayoutConstraint *centerXC = [NSLayoutConstraint constraintWithItem:subview
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:supview
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                  constant:self.anchorPointOffset.x];
    NSLayoutConstraint *centerYC =
    [NSLayoutConstraint constraintWithItem:subview
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:supview
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1
                                  constant:self.anchorPointOffset.y];
    
    centerXC.active = YES;
    centerYC.active = YES;
    
    ///约束
    [supview addConstraints:@[ centerXC,centerYC ]];
    
    
    if(self.adRatio != 0 ){
        
        NSLayoutConstraint *hC;
        hC =
        [NSLayoutConstraint constraintWithItem:subview
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:subview
                                     attribute:NSLayoutAttributeWidth
                                    multiplier:self.adRatio
                                      constant:0];
        hC.active = YES;
        
        ///约束
        [subview addConstraints:@[ hC ]];
        
    }else{
        //不约束
    }
}

//增加Mask视图
- (void)addTapGestureForMask{
    if(self.tapGesture == nil){
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMaskView:) ];
    }
    self.tapGesture.delegate = self;
    
    [self.maskView addGestureRecognizer:self.tapGesture];
    
}

- (void)tapOnMaskView:(UITapGestureRecognizer *)sender{
    if (self.tapAdviewBlock) {
        self.tapAdviewBlock(NO , 0);
    }
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [self removeFromSuperview];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

//手势识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIView *view = touch.view;
    if (view != self.maskView) {
        if (self.tapAdviewBlock) {
            self.tapAdviewBlock(YES , 0);
        }
        return NO;
    }else{
        
    }
    
    return YES;
}

- (UIBezierPath *)getLastBezierPathFor:(CGRect)frame path:(UIBezierPath *)path{
    
    CGFloat radis = MIN(frame.size.width , frame.size.height)/2;
 
    CGPoint a , b ;
    if(frame.size.width > frame.size.height ){
        a = CGPointMake( frame.origin.x + 2 *radis  , frame.origin.y +  radis );
        b = CGPointMake( CGRectGetMaxX(frame)  , frame.origin.y +  radis );
    }else{
        a = CGPointMake( frame.origin.x + radis  , frame.origin.y +  2 *radis );
        b = CGPointMake( frame.origin.x + radis   , CGRectGetMaxY(frame));
    }
    
    UIBezierPath* midPath = UIBezierPath.bezierPath;
    [midPath moveToPoint:a];
    [midPath addLineToPoint:b];
    
    midPath.lineWidth = 2;
    if(path){
        [path appendPath:midPath];
        return path;
        
    }
    
    return midPath;
    
}

- (UIBezierPath *)getDeleteBezierPathFor:(CGRect)frame path:(UIBezierPath *)path{
    
    CGFloat radis = MIN(frame.size.width , frame.size.height)/2;
    
    CGFloat deleteStartX = radis * (1 - sqrtf(2)/2.0 ) ;
    if(deleteStartX < 5)
    {
        deleteStartX = 5;
    }

    CGPoint a = CGPointMake(frame.origin.x + deleteStartX , frame.origin.y + deleteStartX );
    CGPoint b = CGPointMake(frame.origin.x + 2 *radis - deleteStartX , frame.origin.y + deleteStartX );
    CGPoint c = CGPointMake(frame.origin.x + deleteStartX ,  frame.origin.y + 2 *radis - deleteStartX );
    CGPoint d = CGPointMake(frame.origin.x + 2 *radis - deleteStartX ,  frame.origin.y + 2 *radis - deleteStartX );
    
    
    UIBezierPath* midPath = UIBezierPath.bezierPath;
    [midPath moveToPoint:a];
    [midPath addLineToPoint:d];
    
    [midPath moveToPoint:b];
    [midPath addLineToPoint:c];
    
    midPath.lineWidth = 2;
    
    if(path){
        [path appendPath:midPath];
        return path;
        
    }
    return midPath;
    
}
























@end
