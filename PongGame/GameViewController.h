//
//  GameViewController.h
//  PongGame
//
//  Created by Lomtev on 11.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTCGameController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController<LTCGameViewProtocol>

@property (nonatomic) LTCGameMode gameMode;

@end

NS_ASSUME_NONNULL_END
