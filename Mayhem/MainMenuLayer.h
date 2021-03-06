//
//  MainMenuLayer.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "TestScene.h"

@interface MainMenuLayer : CCLayerColor {
    CCLabelTTF *_title;
}

@property (nonatomic, retain) CCLabelTTF *title;

@end
