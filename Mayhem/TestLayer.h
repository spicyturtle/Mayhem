//
//  TestLayer.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

@interface TestLayer : CCLayerColor {
    Player *_player;
}
@property (nonatomic, retain) Player *player;
@end
