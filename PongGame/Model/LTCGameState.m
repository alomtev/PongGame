//
//  LTCGameState.m
//  PongGame
//
//  Created by Lomtev on 18.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import "LTCGameState.h"

@implementation LTCGameState


- (instancetype)initWithGameViewRect:(CGRect)gameViewRect andNavBarRect:(CGRect)navBarRect andBallState:(LTCGameObjectState *)ballState andTopPaddleState:(LTCGameObjectState *)topPaddleState andBottomPaddleState:(LTCGameObjectState *)bottomPaddleState
{
    self = [super init];
    if (self) {
        self.gameViewRect = gameViewRect;
        self.navBarRect = navBarRect;
        self.ballState = ballState;
        self.topPaddleState = topPaddleState;
        self.bottomPaddleState = bottomPaddleState;
    }
    return self;
}

@end
