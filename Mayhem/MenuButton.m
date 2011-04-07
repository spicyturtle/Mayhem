//
//  MenuButton.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/7/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "MenuButton.h"


@implementation MenuButton

+(MenuButton *)buttonFromFile:(NSString *)filename Target:(id)t selector:(SEL)s
{
    return [[self alloc] initWithFile:filename Target:t selector:s];
}

- (id)initWithFile:(NSString *)filename Target: (id)t selector: (SEL) s {
    self = [super initWithFile:filename];
    if (self) {
        
        _target = t;
        _selector = s;
        
        NSMethodSignature *sig = nil;
        
        if (s && t) 
        {
            sig = [t methodSignatureForSelector:s];
            invocation = nil;
            invocation = [NSInvocation invocationWithMethodSignature:sig];
            [invocation setTarget:t];
            [invocation setSelector:s];
            
            // To add (id)sender argument uncomment next line. The way I see it atleast...
//            [invocation setArgument:&self atIndex:2];
            
            [invocation retain];
        }
    }
    return self;
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}


- (BOOL)containsTouchLocation:(UITouch *)touch
{
	// TODO: Implement!
    // CGRectContainsPoint works, but is for rect...
    // Returns true if touch point within button area,
    return true;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	// Call the function initiated with ( [taget selector] ).
    [invocation invoke];
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	// Implement?
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	// Implement?
}


@end
