//
//  MyImageView.m
//  执行拷贝-黏贴操作
//
//  Created by 上海易裁 on 16/9/10.
//  Copyright © 2016年 上海易裁. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView
-(void)awakeFromNib{
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    longPress.minimumPressDuration = 0.5;
    [self addGestureRecognizer:longPress];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 2) {
        [self showMenu:nil];
    }
}
/**  *  4.响应者是否可以执行该方法  *  *  @param action 方法  *  @param sender 请求对象  */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:) && self.image) {
        return YES;
    }    else if (action == @selector(cut:) && self.image) {
        return YES;
    }    else if (action == @selector(paste:) && [UIPasteboard generalPasteboard].image) {
        return YES;
    }    else if (action == @selector(changeColor:)) {
        return YES;
    }    else {
        return NO;
    }
}
//  *  1.是否可以成为第一响应者，默认为NO  *
 - (BOOL)canBecomeFirstResponder {
 return YES;
 }
 - (void)showMenu:(UILongPressGestureRecognizer *)longPress {
 if (longPress.state == UIGestureRecognizerStateEnded || longPress == nil) {        //2.成为第一响应者
 [self becomeFirstResponder];        //添加自定义菜单项
 UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"Change Color" action:@selector(changeColor:)];        //3.创建编辑菜单
 UIMenuController *menu = [UIMenuController sharedMenuController];
 [menu setTargetRect:self.bounds inView:self];
 menu.menuItems = @[item];
 [menu setMenuVisible:YES animated:YES];
 }
 }
 - (void)cut:(id)sender {
 [self copy:sender];
 self.image = nil; }
 - (void)copy:(id)sender {
 [UIPasteboard generalPasteboard].image = self.image;
 }
 - (void)paste:(id)sender {
 UIPasteboard *generalPasteboard = [UIPasteboard generalPasteboard];
 NSMutableArray *types = [[NSMutableArray alloc] init];
 [types addObjectsFromArray:UIPasteboardTypeListImage];
 if ([generalPasteboard containsPasteboardTypes:types]) {
 self.image = generalPasteboard.image;
 }
 }
 - (void)changeColor:(id)sender {
 self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1.0];
 }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
