//
//  TextStatsViewController.m
//  Attributor
//
//  Created by 曾丽辉 on 15/12/25.
//  Copyright © 2015年 Stanford University. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;

@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

//测试用的:
//- (void) viewDidLoad
//{
//    [super viewDidLoad];
//    self.textToanAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
//             NSStrokeColorAttributeName : @-3}];
//}


//设置出口:如果在屏幕上就更新
- (void) setTextToanAnalyze:(NSAttributedString *)textToanAnalyze
{
    _textToanAnalyze = textToanAnalyze;
    if (self.view.window) [self updateUI];
    //self.view.window当前视图所在的方法,如果是nil 则不在当前视图
        
}

//否则使用这个方法更新
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


- (void) updateUI
{
    //如何更新属性化字符串: 找到带有该属性的字符
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful character",[[self charactersWithattrbute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outline character",[[self charactersWithattrbute:NSStrokeColorAttributeName] length]];
}


- (NSAttributedString *) charactersWithattrbute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc]init];
    
    NSInteger index = 0;
    while (index < [self.textToanAnalyze length]) {
        NSRange rang;
        id value = [self.textToanAnalyze attribute:attributeName atIndex:index effectiveRange:&rang];
        if (value) {
            [characters appendAttributedString:[self.textToanAnalyze attributedSubstringFromRange:rang]];
            index = rang.location + rang.length;
        }else{
            index++;
        }
    }
    
    
    return characters;
    
}


@end
