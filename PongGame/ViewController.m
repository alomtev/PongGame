//
//  ViewController.m
//  PongGame
//
//  Created by Lomtev on 10.04.2019.
//  Copyright © 2019 Александр Ломтев. All rights reserved.
//

#import "ViewController.h"
#import "LTCGameController.h"
#import "GameViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *buttonStartGame;
@property (nonatomic, strong) UISegmentedControl *gameModeSegmentedControl;

@property (nonatomic) LTCGameMode gameMode;

@end

static const CGFloat UIElementWidth = 30.0;
static const CGFloat UIElementTopOffset = 30.0;
static const CGFloat ButtonStartGameWidth = 130.0;
static const CGFloat ButtonStartGameHight = 30.0;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - createUI

- (void)createUI
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) / 4, CGRectGetWidth(self.view.frame), UIElementWidth)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"Выберите сложность игры:";
    [self.view addSubview:self.label];
    
    NSArray *gameModes = @[@"Новичек", @"Ветеран", @"Хардкор!!"];
    
    self.gameModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:gameModes];
    self.gameModeSegmentedControl.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.view.frame), UIElementWidth);
    self.gameMode = LTCGameModeEase;
    self.gameModeSegmentedControl.selectedSegmentIndex = self.gameMode;
    [self.gameModeSegmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.gameModeSegmentedControl];
    
    self.buttonStartGame = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonStartGame.frame = CGRectMake(self.view.center.x - ButtonStartGameWidth/2, CGRectGetMaxY(self.gameModeSegmentedControl.frame) + UIElementTopOffset, ButtonStartGameWidth, ButtonStartGameHight);
    [self.buttonStartGame setTitle:@"Начать игру!" forState:UIControlStateNormal];
    [self.buttonStartGame setBackgroundColor:[UIColor blueColor]];
    [self.buttonStartGame addTarget:self action:@selector(touchUpButtonStartGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.buttonStartGame];
    
    self.navigationItem.title = @"Меню игры";
    
}

#pragma mark - Event handlers

- (void)touchUpButtonStartGame
{
    NSLog(@"touchUpButtonStartGame!!");
    GameViewController *gameViewController = [[GameViewController alloc] init];
    gameViewController.gameMode = self.gameMode;
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (void)valueChanged:(id)sender
{
    NSLog(@"UISegmentedControl value change!!");
    UISegmentedControl *segmentedControl = sender;
    self.gameMode = segmentedControl.selectedSegmentIndex;
}


@end
