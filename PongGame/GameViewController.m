//
//  GameViewController.m
//  PongGame
//
//  Created by Lomtev on 11.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import "GameViewController.h"
#import "LTCGameController.h"
#import "Model/LTCGameObjectState.h"

@interface GameViewController ()

@property (strong, nonatomic) LTCGameController *ltsGameController;

@property (strong, nonatomic) UIView *topPaddle;
@property (strong, nonatomic) UIView *bottomPaddle;
@property (strong, nonatomic) UIView *ball;
@property (strong, nonatomic) UILabel *textLabel;

@end


@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
    self.ltsGameController = [[LTCGameController alloc] initWithGameMode:self.gameMode];
    self.ltsGameController.delegate = self;
    [self.ltsGameController startGame];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.topPaddle = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 30.0, [self getTopPaddleY], 60.0, 5.0)];
    self.topPaddle.backgroundColor = [UIColor grayColor];
    [self.view addSubview: self.topPaddle];
    
    self.bottomPaddle = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 30.0, self.view.frame.size.height - 5.0, 60.0, 5.0)];
    self.bottomPaddle.backgroundColor = [UIColor grayColor];
    [self.view addSubview: self.bottomPaddle];
    
    self.ball = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    self.ball.backgroundColor = [UIColor magentaColor];
    self.ball.layer.masksToBounds = YES;
    self.ball.layer.cornerRadius = self.ball.frame.size.width / 2;
    [self.view addSubview: self.ball];

    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [self getTopPaddleY], 200, 50)];
    self.textLabel.textColor = [UIColor cyanColor];
    self.textLabel.text = @"0";
    [self.view addSubview:self.textLabel];
    
}

- (CGFloat)getTopPaddleY
{
    return CGRectGetMaxY(self.navigationController.navigationBar.frame);
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self.view];
    
    // Простейшая проверка, чтобы bottomPaddle не уезжал за границы экрана
    if (currentPoint.x >= self.view.frame.size.width - 30.0)
    {
        self.bottomPaddle.center = CGPointMake(self.view.frame.size.width - 30.0, self.view.frame.size.height - 2.5);
    }
    else if (currentPoint.x <= 30.0)
    {
        self.bottomPaddle.center = CGPointMake(30.0, self.view.frame.size.height - 2.5);
    }
    else
    {
        self.bottomPaddle.center = CGPointMake(currentPoint.x, self.view.frame.size.height - 2.5);
    }
}

# pragma mark - LTCGameViewProtocol implemention

- (void)onBeforeStartGame
{
    self.ball.center = self.view.center;
}

- (nonnull LTCGameState *)onBeforeMoveBall
{
    LTCGameObjectState *ballState = [[LTCGameObjectState alloc] initWithCenter:self.ball.center andRect:self.ball.frame];
    LTCGameObjectState *topPaddleState = [[LTCGameObjectState alloc] initWithCenter:self.topPaddle.center andRect:self.topPaddle.frame];
    LTCGameObjectState *bottomPaddleState = [[LTCGameObjectState alloc] initWithCenter:self.bottomPaddle.center andRect:self.bottomPaddle.frame];
    
    LTCGameState *gameState = [[LTCGameState alloc] initWithGameViewRect:self.view.frame andNavBarRect:self.navigationController.navigationBar.frame andBallState:ballState andTopPaddleState:topPaddleState andBottomPaddleState:bottomPaddleState];
    
    return gameState;
}

- (void)onMoveBallWithBallCenter:(CGPoint)ballCenter andTopPaddingCenter:(CGPoint)topPaddingCenter andBottomPaddingCenter:(CGPoint)bottomPaddingCenter andCurrentScore:(NSUInteger)currentScore
{
    self.ball.center = ballCenter;
    self.topPaddle.center = topPaddingCenter;
    self.bottomPaddle.center = bottomPaddingCenter;
    self.textLabel.text = [NSString stringWithFormat:@"%lu",currentScore];
}

- (void)onGameOver
{
    self.ltsGameController = [[LTCGameController alloc] initWithGameMode:self.gameMode];
    self.ltsGameController.delegate = self;
    [self.ltsGameController startGame];
    
}

@end
