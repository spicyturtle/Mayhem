//
//  Player.mm
//  Mayhem
//
//  Created by Kim Sørensen on 4/10/11.
//  Copyright 2011 UiT. All rights reserved.
//
#import "HUDLayer.h"


@implementation HUDLayer

+(HUDLayer *)HUDToPlayer:(Player *)player
{
    return [[self alloc] initWithPlayer:player];
}

- (id)initWithPlayer:(Player *)player {
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
    if (self) {
        
        _player = player;
        // Get winSize
        CGSize winSize = GET_WINSIZE();
        
        fuelgauge = [[CCLabelAtlas labelWithString:@"99.0" charMapFile:@"fps_images.png" itemWidth:16 itemHeight:24 startCharMap:'.'] retain];
        
		[self addChild:fuelgauge z:0];
        
		fuelgauge.position = ccp(winSize.width - 100 ,winSize.height - 48);
		fuelgauge.opacity = 200;
        
        [self schedule:@selector(updateHUD:) interval:0.5f];
    }
    
    return self;
}


-(void)updateHUD:(ccTime) dt{
    
    NSString *str = [[NSString alloc] initWithFormat:@"%.d", (int)_player.fuel];
    [fuelgauge setString:str];
    [str release];
}

- (void)dealloc {
    [super dealloc];
}

@end
