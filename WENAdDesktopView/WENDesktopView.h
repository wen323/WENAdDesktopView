//
//  WENDesktopView.h
//  ADViewDemo
//
//  Created by HS001 on 2016/12/12.
//  Copyright © 2016年 ISNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WENDesktopView : UIView



///广告的锚点的anchorPointOffset
@property (assign,nonatomic) IBInspectable CGPoint anchorPointOffset;
///广告的宽度比例,=0 表示不约束,直接使用adview 的宽度
@property (assign,nonatomic) IBInspectable CGFloat widthToSuperView;
///广告的高宽比 ,=0 表示不约束,直接使用adview 的高度
@property (assign,nonatomic) IBInspectable CGFloat adRatio;
///删除按钮的大小
@property (assign,nonatomic) IBInspectable CGFloat delIconWidth;
///删除按钮对应 ad 的距离
@property (assign,nonatomic) IBInspectable CGFloat delIconDelt;
///关闭按钮的颜色
@property ( strong,nonatomic) IBInspectable UIColor *closeBtnColor;
///广告,single or more
@property ( strong,nonatomic) UIView *adView;
///mask视图
@property ( strong,nonatomic) UIView *maskView;
///非自定义 adview 的点击动作 block
@property ( copy,nonatomic) void (^tapAdviewBlock)( bool tapAdview ,NSInteger index) ;

///是否显示删除按钮
@property ( assign,nonatomic) IBInspectable BOOL showDelBtn;


///显示的 view,image 作为 ad 为默认的 imageview 时使用,其他自定义的adview 按照对应的设置
- (void)showInView:(UIView *)view image: (UIImage *)image;



@end
