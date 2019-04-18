//
//  LTCGameObjectState.h
//  PongGame
//
//  Created by Lomtev on 18.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Класс для представления состояния объекта игры
 */
@interface LTCGameObjectState : NSObject

/**
 Rect объекта
 */
@property (nonatomic, assign) CGRect gameObjectRect;


/**
 Точка центра объекта
 */
@property (nonatomic, assign) CGPoint gameObjectCenter;


/**
 Точка центра объекта
 */
- (instancetype)initWithCenter:(CGPoint)center andRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
