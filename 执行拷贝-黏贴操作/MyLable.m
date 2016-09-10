//
//  MyLable.m
//  执行拷贝-黏贴操作
//
//  Created by 上海易裁 on 16/9/10.
//  Copyright © 2016年 上海易裁. All rights reserved.
//

#import "MyLable.h"

@implementation MyLable
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]init];
        longPress.minimumPressDuration= 0.5;
        [self addGestureRecognizer:longPress];
    }
    return self;
    }
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 2) {
        [self showMenu:nil];
        
    }
}
- (void)showMenu:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateEnded || longPress == nil) {        //2.成为第一响应者
       [self becomeFirstResponder];        //添加自定义菜单项
    //  UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"Change Color" action:@selector(changeColor:)];        //3.创建编辑菜单
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.bounds inView:self];
    //  menu.menuItems = @[item];
        [menu setMenuVisible:YES animated:YES];
    }
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(copy:)&& self.text) {
        return YES;
    }else if (action == @selector(cut:)&&self.text){
        return YES;
    }else if (action == @selector(paste:)&& [UIPasteboard generalPasteboard].string){
        return YES;
    }else{
        return NO;
    }
}
-(void)cut:(id)sender{
    [self copy:sender];
    self.text = nil;
}
- (void)copy:(id)sender{
    [UIPasteboard generalPasteboard].string = self.text;
}
- (void)paste:(id)sender{
    UIPasteboard *generalPasteboard = [UIPasteboard generalPasteboard];
    NSMutableArray *types = [[NSMutableArray alloc]init];
    [types addObjectsFromArray:UIPasteboardTypeListString];
    if ([generalPasteboard containsPasteboardTypes:types]) {
        self.text = generalPasteboard.string;
    }
}

@end
