//
//  Common.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/5/11.
//  Copyright 2011 UiT. All rights reserved.
//

// Pixel to Meter ratio
#define PTM_RATIO 32.0

#define GET_WINSIZE() [[CCDirector sharedDirector] winSize]


enum {
    PLAYER = 0,
    PLAYER_WEAPON,
    ENEMY,
    ENEMY_WEAPON,
    FUEL,
    OBSTACLE
};

#define ENEMY_WEAPON_VELOCITY 10.0f;
#define PLAYER_WEAPON_VELOCITY 42.0f;


