//
//  LTCGameObjectState.m
//  PongGame
//
//  Created by Lomtev on 18.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//


#import "LTCGameObjectState.h"

@implementation LTCGameObjectState


- (instancetype)initWithCenter:(CGPoint)center andRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.gameObjectCenter = center;
        self.gameObjectRect = rect;
    }
    return self;
}

@end
