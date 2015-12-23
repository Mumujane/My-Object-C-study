//
//  Card.m
//  Michismon
//
//  Created by 曾丽辉 on 15/12/21.
//  Copyright © 2015年 Mumu_Zeng. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int) match:(NSArray *)otherCards {
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {            
            score = 1;
       }
    }
    return score;
}

@end
