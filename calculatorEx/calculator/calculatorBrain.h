//
//  calculatorBrain.h
//  calculator
//
//  Created by pony ma on 4/23/14.
//  Copyright (c) 2014 pony ma. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface calculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@property (nonatomic, readonly) id program;
+ (double) runProgram:(id)program;
+ (NSString *) descriptionOfProgram:(id)program;

@end
