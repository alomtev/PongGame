//
//  GameController.m
//  PongGame
//
//  Created by Lomtev on 17.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import "LTCGameController.h"
#import <UIKit/UIKit.h>


@interface LTCGameController ()

@property (assign, nonatomic) CGFloat dX;
@property (assign, nonatomic) CGFloat dY;
@property (assign, nonatomic) NSUInteger hiScore;
@property (assign, nonatomic) NSUInteger currentScore;
@property (strong, nonatomic) NSTimer *gameTimer;
@property (assign, nonatomic) double currentSpeed;
@property (assign, nonatomic) CGPoint savePoint;

@end

static const double speedDefault = 0.005f;
static const double speedNormal = 0.0025f;
static const double speedMaximim = 0.001f;

@implementation LTCGameController

- (instancetype)initWithGameMode:(LTCGameMode)gameMode
{
    self = [super init];
    if (self) {
        self.gameMode = gameMode;
        self.currentSpeed = speedDefault;
        self.currentScore = 0;
    }
    return self;
}

#pragma mark - Public game methods

- (void)startGame
{
    //задать начальные значения скрости
    self.currentSpeed = [self getGameSpeed];
    self.dX = self.dY = 1.0;
    
    // должен установить center для ball
    [self.delegate onBeforeStartGame];
    
    //установить таймер
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:self.currentSpeed target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
}


#pragma mark - Private game methods


- (void)moveBall
{
    // получаем текущее состояние игры
    LTCGameState *gameState = [self.delegate onBeforeMoveBall];
    
    CGPoint currentBallCenterPoint = gameState.ballState.gameObjectCenter;
    CGRect gameRect = gameState.gameViewRect;
    CGRect navBarRect = gameState.navBarRect;
    CGRect ballRect = gameState.ballState.gameObjectRect;
    CGRect topPaddleRect = gameState.topPaddleState.gameObjectRect;
    CGRect bottomPaddleRect = gameState.bottomPaddleState.gameObjectRect;
    
    CGRect currentTopPaddleRect = gameState.topPaddleState.gameObjectRect;
    
    CGPoint nextTopPaddleCenterPoint = gameState.topPaddleState.gameObjectCenter;
    CGPoint nextBottomPaddleCenterPoint = gameState.bottomPaddleState.gameObjectCenter;
    
    // Простейшая проверка, чтобы topPaddle не уезжал за границы экрана
    if (currentBallCenterPoint.x >= gameRect.size.width - CGRectGetWidth(currentTopPaddleRect)/2)
    {
        nextTopPaddleCenterPoint = CGPointMake(gameRect.size.width - CGRectGetWidth(currentTopPaddleRect)/2, [self getTopPaddleYFromNavBarRect:navBarRect]);
    }
    else if (currentBallCenterPoint.x <= CGRectGetWidth(currentTopPaddleRect)/2)
    {
        nextTopPaddleCenterPoint = CGPointMake(CGRectGetWidth(currentTopPaddleRect)/2, [self getTopPaddleYFromNavBarRect:navBarRect]);
    }
    else
    {
        nextTopPaddleCenterPoint = CGPointMake(currentBallCenterPoint.x, [self getTopPaddleYFromNavBarRect:navBarRect]);
    }
    
    if (CGRectIntersectsRect(ballRect, topPaddleRect))
    {
        // шарик столкнулся с topPaddle
        self.dY *= -1;
    }
    else if (CGRectIntersectsRect(ballRect, bottomPaddleRect))
    {
        // шарик столкнулся с bottomPaddle
        self.currentScore++;
        self.dY *= -1;
    }
     
    if ((ballRect.origin.x + CGRectGetWidth(ballRect) > CGRectGetWidth(gameRect)) ||
     (ballRect.origin.x < 0))
    {
        // шарик столкнулся с боковыми границами
        self.dX *= -1;
    }
     
    if (ballRect.origin.y + CGRectGetHeight(ballRect) > CGRectGetHeight(gameRect))
    {
        // шарик столкнулся с нижней границей
        // Завершаем игру
        [self gameOver];
        
        // завершить алгоритм??
    }
    if(ballRect.origin.y < 0)
    {
        // шарик столкнулся с верхней границей
        // Сюда не будет заходить т.к topPaddle, в текущей реализации не пропустит шарик
        self.currentScore++;
        // Завершаем игру
        [self gameOver];
        
        // завершить алгоритм??
    }
    CGPoint nextBallCenterPoint = CGPointMake(currentBallCenterPoint.x + self.dX, currentBallCenterPoint.y + self.dY);
    
    [self.delegate onMoveBallWithBallCenter:nextBallCenterPoint andTopPaddingCenter:nextTopPaddleCenterPoint andBottomPaddingCenter:nextBottomPaddleCenterPoint andCurrentScore:self.currentScore];
}

- (void)gameOver
{
    // завершить игру onGameOver
    [self stopTimer];
    [self.delegate onGameOver];
}

- (double)getGameSpeed
{
    if(self.gameMode == LTCGameModeNormal){
        return speedNormal;
    }else if(self.gameMode == LTCGameModeHard){
        return speedMaximim;
    }else{
        return speedDefault;
    }
}

- (CGFloat)getTopPaddleYFromNavBarRect:(CGRect) rect
{
    return CGRectGetMaxY(rect);
}

- (void)stopTimer
{
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}

@end
