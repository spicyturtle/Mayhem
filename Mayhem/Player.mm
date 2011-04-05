//
//  Player.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "Player.h"


@implementation Player

- (id)init {
    self = [super init];
    if (self) {
        // Set self to be a Sprite from a file.
        self = [CCSprite spriteWithFile:@"player.png" rect:CGRectMake(0, 0, 64, 64)];
    }
    return self;
}

- (void)dealloc {
    
    // Must have
    [super dealloc];
}

@end
