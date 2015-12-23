//
//  PlayingCard.h
//  Michismon
//
//  Created by 曾丽辉 on 15/12/21.
//  Copyright © 2015年 Mumu_Zeng. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
