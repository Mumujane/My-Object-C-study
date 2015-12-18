//
//  calculatorViewController.m
//  calculator
//
//  Created by pony ma on 4/23/14.
//  Copyright (c) 2014 pony ma. All rights reserved.
//

#import "calculatorViewController.h"
#import "calculatorBrain.h"

@interface calculatorViewController ()
@property (nonatomic) BOOL isInTheMiddleOfEnteringNumber;
@property (nonatomic, strong)calculatorBrain *calBrain;
@end

@implementation calculatorViewController


//同样在getter里初始化,延迟初始化，因为我只有在用它的时候才
//初始化
-(calculatorBrain *)calBrain
{
    if (!_calBrain)
    {
        _calBrain = [[calculatorBrain alloc]init];
    }
    return _calBrain; 
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    if (self.isInTheMiddleOfEnteringNumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.isInTheMiddleOfEnteringNumber = YES;
    }
    
}

//操作方法，比如要计算6+3, 按下6->enter->3->'+',得到结果
//连续加的情况，后面就不用再输enter了，一直往下输入即可.
//
- (IBAction)operationPressed:(UIButton *)sender
{
    //注意这里，比如用户输入6*3,按下*按钮时，会自动把6压栈，
    //这样不用每输一个数字就按一下enter。
    if (self.isInTheMiddleOfEnteringNumber)
    {
        [self enterPressed];
    }
    double result = [self.calBrain performOperation:sender.currentTitle];
    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

//把输入的数字压栈
- (IBAction)enterPressed
{
    [self.calBrain pushOperand:[self.display.text doubleValue]];
    self.isInTheMiddleOfEnteringNumber = NO;
    
}






@end
