//
//  calculatorBrain.m
//  calculator
//
//  Created by pony ma on 4/23/14.
//  Copyright (c) 2014 pony ma. All rights reserved.
//


#import "calculatorBrain.h"

@interface calculatorBrain ()
@property (nonatomic, strong) NSMutableArray *programStack; //可以存操作数和操作符。
@end

@implementation calculatorBrain

//我们要在这里初始化operandStack, 所以重写getter方法
//注意里面用下划线的访问形式.
-(NSMutableArray *)programStack
{
    if (_programStack == nil) {
        _programStack = [[NSMutableArray alloc]init];
    }
    return _programStack;
}

-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

//-(double)popOperand
//{
//    NSNumber *operandObject = [self.operandStack lastObject];
//    
//    //注意这里，如果operandObject为nil, 下面执行remove会让程序崩溃，所以要加上判断
//    //lastObject方法不用判断
//    if (operandObject)
//    {
//        [self.operandStack removeLastObject];
//    }
//    
//    return [operandObject doubleValue];
//}


-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation]; //操作符也进栈
    return [[self class] runProgram:self.programStack];//注意这里的用法
}

-(id)program
{
    return [self.program copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"implement this in Assigment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    //注意类型是id, 因为取出来的可能是操作数，也可能是操作符。
    id topStack = [stack lastObject];
    if (topStack)
    {
        [stack removeLastObject];
    }
    
    if ([topStack isKindOfClass:[NSNumber class]])
    {
        result = [topStack doubleValue];
    }
    else if([topStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topStack;
        
        if ([operation isEqualToString:@"+"]) 
        {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"*"]) 
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"-"])
        {
            double subtractor = [self popOperandOffStack:stack];//先出来的是减数
            double subtracted = [self popOperandOffStack:stack];//后出来的是被减数
            result = subtracted - subtractor;
        }
        else if ([operation isEqualToString:@"/"])
        {
            double divider = [self popOperandOffStack:stack];//先出来的是除数
            double dividend = [self popOperandOffStack:stack];//后出来的是被除数
            result = dividend / divider;
        }

        
    }
    
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]])
    {
        //注意这个判断条件是不能少的，并不是id类型都有mutableCopy方法。
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}


/*
    double result = 0;
    
    //这里只实现加法
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    
    //结果压回栈，这样可以做连续运算
    [self pushOperand:result];
    return result;
}
 
 */


@end
