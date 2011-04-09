//
//  MenuButton.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/7/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuButton : CCSprite <CCTargetedTouchDelegate> {
    id _target;
    SEL _selector;
    CGRect _rect;
    NSInvocation *invocation;
}

@property (nonatomic) CGRect rect;

-(id)initWithFile:(NSString *)filename Target: (id)t selector: (SEL) s;

+(MenuButton *)buttonFromFile:(NSString *)filename Target: (id)t selector: (SEL) s;

@end
