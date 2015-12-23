//
//  CardMatchingGame.m
//  Michismon
//
//  Created by 曾丽辉 on 15/12/21.
//  Copyright © 2015年 Mumu_Zeng. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    self = [super self];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;  //匹配错,罚两分
static const int MATCH_BONUS = 4;       //匹配对,四倍奖励
static const int COST_TO_CHOOSE = 1;    //翻牌成本

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card * card = [self cardAtIndex:index];
    //getter = isChosen ,setter 不是
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO; //两次选择,等于取消选择(开关)
        } else {
            //选择了一张新牌,将它和其他纸牌比较(两张):检查纸牌数组中的所有其他牌
            
            for (Card *otherCard in self.cards) {
                //被选了,但是没有匹配
                if (otherCard.isChosen && !otherCard.isMatched) {
                    //创造一个数组,(参数是数组)
                    int matchScore = [card match:@[otherCard]];
                    //NSLog(@"matchScore:%zd",matchScore);
                    
                    //返回非0 ,则匹配成功
                    if (matchScore) {
                        self.score  += matchScore * MATCH_BONUS;
                        
                         //NSLog(@"self.score:%zd",self.score);
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
