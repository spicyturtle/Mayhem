//
//  TestLayer.mm
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "TestLayer.h"

@implementation TestLayer

@synthesize player = _player;

+(TestLayer *)layerWithWorld:(b2World *)world andPlayer:(Player *)player
{
    return [[self alloc] initWithWorld:world andPlayer:player];
}

- (id)init {
    self = [super init];
    if (self) {
        
        _world = [World getWorld];
                
        // Add objects to layer here
        self.player = [[Player alloc] initWithWorld:_world];
        [self addChild:_player];
        
        [self runAction:[CCFollow actionWithTarget:_player]];
        
        [self schedule:@selector(tick:)];
        
    }
    return self;
}

- (id)initWithWorld: (b2World *)world andPlayer:(Player *)player {
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
    if (self) {
        
        CGSize winSize = CGSizeMake(1280.0f, 800.0f);
        
        _world = world;
        
        CCSprite* background = [CCSprite spriteWithFile:@"background720.jpg"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background z:-2];
        
        // Add objects to layer here
        self.player = player;
        [self addChild:_player];
    
        LandingPlatform *landingPlatform;
        landingPlatform = [LandingPlatform landingPlatformInWorld:_world];
        [self addChild:landingPlatform];
        
        // Add Contact Listener
        _contactListener = new MyContactListener();
        _world->SetContactListener(_contactListener);
        
        StaticEnemy *enemy1;
        enemy1 = [StaticEnemy enemyInWorld:_world];
        [self addChild:enemy1];
        
        StaticEnemy *enemy2;
        enemy2 = [StaticEnemy enemyInWorld:_world];
        [self addChild:enemy2];
        
        Obstacle *obstacle1;
        obstacle1 = [Obstacle obstacleInWorld:_world];
        
        [self addChild:obstacle1];
        
        [self runAction:[CCFollow actionWithTarget:_player worldBoundary:CGRectMake(0, 0, winSize.width, winSize.height)]];
        
        [self schedule:@selector(tick:)];
    }
    
    return self;
}

-(void)tick:(ccTime) dt
{
    BOOL enemyLeft = false;
    _world->Step(dt, 10, 10);    
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {    
        if (b->GetUserData() != NULL) {
            CCSprite *sprite = (CCSprite *)b->GetUserData();                        
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO,
                                  b->GetPosition().y * PTM_RATIO);
            sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            if (sprite.tag == ENEMY) enemyLeft = true;
        }  
        
    }
    std::vector<b2Body *>toDestroy;
    std::vector<MyContact>::iterator pos;
    for(pos = _contactListener->_contacts.begin(); 
        pos != _contactListener->_contacts.end(); ++pos) {
        MyContact contact = *pos;
        
        b2Body *bodyA = contact.fixtureA->GetBody();
        b2Body *bodyB = contact.fixtureB->GetBody();
        
        if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL) {
            CCSprite *spriteA = (CCSprite *) bodyA->GetUserData();
            CCSprite *spriteB = (CCSprite *) bodyB->GetUserData();
            
            // Check Collision between player weapon and enemy
            if (spriteA.tag == PLAYER_WEAPON  && spriteB.tag == ENEMY) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyB);
                }
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyA);
                }
            }
            
            // Check Collision between player weapon and enemy
            if (spriteA.tag == ENEMY  && spriteB.tag == PLAYER_WEAPON) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyB);
                }
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyA);
                }
            }
            
            // Check Collision between enemy weapon and player
            if (spriteA.tag == PLAYER  && spriteB.tag == ENEMY_WEAPON) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyB);
                    _player.fuel -= 10;
                }
            }
            // Check Collision between enemy weapon and player
            if (spriteA.tag == ENEMY_WEAPON && spriteB.tag == PLAYER) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyA);
                    _player.fuel -= 10;
                }
            }
            // Check Collision between enemy weapon and player
            if (spriteA.tag == PLATFORM  && spriteB.tag == ENEMY_WEAPON) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyB);
                }
            }
            // Check Collision between enemy weapon and player
            if (spriteA.tag == ENEMY_WEAPON && spriteB.tag == PLATFORM) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyA);
                }
            }
            // Check Collision between fuelpad and player
            if (spriteA.tag == PLATFORM && spriteB.tag == PLAYER) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    float32 angle = [self.player getAngle];
                    if (angle < 90 || angle > 270) {                       
                        [self.player refuel];
                    }
                }
            }
            // Check Collision between fuelpad and player
            if (spriteA.tag == PLAYER && spriteB.tag == PLATFORM) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    float32 angle = [self.player getAngle];
                    if (angle < 90 || angle > 270) {
                        [self.player refuel];
                    }
                }
            }
            // Check Collision between obstacle and player
            if (spriteA.tag == PLAYER && spriteB.tag == OBSTACLE) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    _player.fuel = -1.0f;
                }
            }
            // Check Collision between obstacle and player
            if (spriteA.tag == OBSTACLE && spriteB.tag == PLAYER) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    _player.fuel = -1.0f;
                }
            }
        }
        else if(bodyA->GetUserData() != NULL) {
            CCSprite *spriteA = (CCSprite *) bodyA->GetUserData();
            if (spriteA.tag == PLAYER_WEAPON || spriteA.tag == ENEMY_WEAPON) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyA) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyA);
                }
            }
        }
        else if(bodyB->GetUserData() != NULL) {
            CCSprite *spriteB = (CCSprite *) bodyB->GetUserData();
            if (spriteB.tag == PLAYER_WEAPON || spriteB.tag == ENEMY_WEAPON) {
                if (std::find(toDestroy.begin(), toDestroy.end(), bodyB) 
                    == toDestroy.end()) {
                    toDestroy.push_back(bodyB);
                }
            }
        }


    }
    std::vector<b2Body *>::iterator pos2;
    for(pos2 = toDestroy.begin(); pos2 != toDestroy.end(); ++pos2) {
        b2Body *body = *pos2;     
        if (body->GetUserData() != NULL) {
            CCSprite *sprite = (CCSprite *) body->GetUserData();
            [self removeChild:sprite cleanup:YES];
        }
        _world->DestroyBody(body);
    }
    
    
    if (!enemyLeft) {
        GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"You Win :]"];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
        
    }
    else if(_player.fuel <= 0.0) {
        GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"You Lose :["];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
        
    }
    
    
    
    
}

// on "dealloc" you need to release all your retained objects
- (void)dealloc {
    
    delete _contactListener;
    delete _world;
    [super dealloc];
    
}

@end
