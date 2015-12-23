//
//  Deck.h
//  Michismon
//
//  Created by 曾丽辉 on 15/12/21.
//  Copyright © 2015年 Mumu_Zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
