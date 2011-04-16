//
//  StaticEnemy.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/7/11.
//  Copyright 2011 UiT. All rights reserved.
//

#import "StaticEnemy.h"


@implementation StaticEnemy

+(StaticEnemy *)enemyInWorld:(b2World *)world atX:(float) x andY:(float)y
{
    return [[self alloc] initWithWorld:world atPos:CGPointMake(x, y)];
}


- (id)initWithWorld:(b2World *)world atPos:(CGPoint)pos{
    self = [super initWithFile:@"StaticEnemy.png"];
    if (self) {
        // Initialize enemy
        self.tag = ENEMY;
            
        // Create enemy body
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(pos.x/PTM_RATIO, pos.y/PTM_RATIO);
        bodyDef.userData = self;
        _body = world->CreateBody(&bodyDef);
        
        // Create player shape
        b2CircleShape shape;
        shape.m_radius = 16.0/PTM_RATIO;
        
        // Create shape definition
        b2FixtureDef shapeDef;
        shapeDef.shape = &shape;
        shapeDef.density = 1.0f;
        shapeDef.friction = 0.0f;
        shapeDef.restitution = 1.0f;
        _fixture = _body->CreateFixture(&shapeDef);
        
        _body->SetAngularDamping(0.0f);
        _body->ApplyAngularImpulse(1.0f);
        _body->ApplyForce(_body->GetLocalCenter(),b2Vec2(0.0f,1.5f));
        
        
        [self schedule:@selector(enemyGameLogic:) interval:2.0f];
        
    }
    return self;
}

- (void)fire {
    b2World *world = _body->GetWorld();
    b2Vec2 pos = _body->GetPosition();
    float32 angle = _body->GetAngle();
    
    Weapon *bullet = [[Weapon alloc] initWithWorld:world point:pos angle:angle size:self.contentSize type:ENEMY_WEAPON];

    [self.parent addChild:bullet];

}


-(void)enemyGameLogic:(ccTime)dt {
    
    [self fire];
}
@end
