//
//  LTCGameController.h
//  PongGame
//
//  Created by Lomtev on 17.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model/LTCGameState.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Перечисление с режимами сложности игры
 */
typedef NS_ENUM(NSInteger, LTCGameMode) {
    LTCGameModeEase,     // Новичек
    LTCGameModeNormal,   // Ветеран
    LTCGameModeHard,     // Хардкор
};


/**
 Протокол который должен реализовывать view слой игры
 */
@protocol LTCGameViewProtocol


/**
 Метод предназначен для настроек view перед стартом игры
 */
- (void)onBeforeStartGame;

/**
 Метод предназначен для сбора информации о состоянии view перед следующим движением объектов игры
 
 @return экземпляр LTCGameState
 */
- (LTCGameState *)onBeforeMoveBall;


/**
 Метод предназначен для реализации отображения во view объектов игры - следующее движение игры
 */
- (void)onMoveBallWithBallCenter:(CGPoint)ballCenter andTopPaddingCenter:(CGPoint)topPaddingCenter andBottomPaddingCenter:(CGPoint)bottomPaddingCenter andCurrentScore:(NSUInteger)currentScore;


/**
 Метод предназначен для реализации логики view при завершении игры
 */
- (void)onGameOver;

@end

@interface LTCGameController : NSObject

@property (nonatomic, assign) LTCGameMode gameMode;
@property (nonatomic, weak) id<LTCGameViewProtocol>delegate;

- (instancetype)initWithGameMode:(LTCGameMode)gameMode;
- (void)startGame;

@end

NS_ASSUME_NONNULL_END
