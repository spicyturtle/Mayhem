//
//  GameOverScene.h
//  Ninjas
//
//  Created by Kim Sørensen on 04.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
    CCLabelTTF *_label;
    CCDirector *_director;
}
@property (nonatomic, retain) CCLabelTTF *label;
@end

@interface GameOverScene : CCScene {
    GameOverLayer *_layer;
}
@property (nonatomic, retain) GameOverLayer *layer;
@end
