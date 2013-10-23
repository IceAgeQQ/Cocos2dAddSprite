//
//  HelloWorldLayer.m
//  2dAddSprite
//
//  Created by Chao Xu on 13-8-4.
//  Copyright Chao Xu 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "addSprite.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
@synthesize spriteArray;
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
    
		self.isTouchEnabled = YES;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        self.spriteArray = array;
        [array release];
        addSprite *sprite = [[addSprite alloc]init];
        sprite.position = ccp(240, 160);
        [spriteArray addObject:sprite];
        [self addChild:sprite];
        
        
			}
	return self;
}

-(void) checkForTap:(CGPoint)touch{
    int i;
    BOOL yesOrNo = NO;
    for (i=0; i<[spriteArray count]; i++) {
        addSprite *sprite = (addSprite *)[spriteArray objectAtIndex:i];
        BOOL spriteTapped = [self circle:touch withRadius:1 collisionWithCircle:CGPointMake(sprite.position.x, sprite.position.y) collisionWithCircleRadius:20];
        if (spriteTapped) {
            yesOrNo = YES;
            [self removeChild:sprite cleanup:NO];
            [spriteArray removeObjectAtIndex:i];
        }
    }
    if (yesOrNo == NO) {
        addSprite *addedSprite = [[addSprite alloc]init];
        addedSprite.position = ccp(touch.x,touch.y);
        [spriteArray addObject:addedSprite];
        [self addChild:addedSprite];
    }
}
-(BOOL)circle:(CGPoint)circlePoint withRadius:(float)radius collisionWithCircle:(CGPoint) circlePointTwo collisionWithCircleRadius:(float) radiusTwo{
    float xdif = circlePoint.x - circlePointTwo.x;
    float ydif = circlePoint.y - circlePointTwo.y;
    float distance = sqrt(xdif*xdif +ydif*ydif);
    if (distance <= radius + radiusTwo) return YES;
    
    return  NO;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *myTouch = [touches anyObject];
    CGPoint point = [myTouch locationInView:[myTouch view]];
    CGPoint convert  = [[CCDirector sharedDirector]convertToGL:point];
    [self checkForTap:convert];
    
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
