//
//  LTCGameState.h
//  PongGame
//
//  Created by Lomtev on 18.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LTCGameObjectState.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Класс для представления текущего состояния игры
 */
@interface LTCGameState : NSObject


/**
 Rect в котором запущена игра
 */
@property (nonatomic, assign) CGRect gameViewRect;


/**
 Rect навигационной панели
 */
@property (nonatomic, assign) CGRect navBarRect;


/**
 Текущая позиция шарика
 */
@property (nonatomic, strong) LTCGameObjectState *ballState;


/**
 Текущее состояние topPaddle
 */
@property (nonatomic, strong) LTCGameObjectState *topPaddleState;


/**
 Текущее состояние bottomPaddle
 */
@property (nonatomic, strong) LTCGameObjectState *bottomPaddleState;


/**
 Инициализатор - возвращает экземпляр LTCGameObjectState
 */
- (instancetype)initWithGameViewRect:(CGRect)gameViewRect andNavBarRect:(CGRect)navBarRect andBallState:(LTCGameObjectState *)ballState andTopPaddleState:(LTCGameObjectState *)topPaddleState andBottomPaddleState:(LTCGameObjectState *)bottomPaddleState;

@end

NS_ASSUME_NONNULL_END
