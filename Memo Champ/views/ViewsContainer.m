//
//  ViewsContainer.m
//  Memo Champ
//
//  Created by Zbigniew Kominek on 11/30/11.
//  Copyright (c) 2011 Zbigniew Kominek. All rights reserved.
//

#import "ViewsContainer.h"
#import "MenuViewController.h"
#import "ShowViewController.h"

const NSTimeInterval TRANSITION_DURATION = 0.5f;

@interface ViewsContainer (ViewsRotation)

- (void) rotateNewView:(UIView*)newView toOrientationOfView:(UIView*)view;

@end

@implementation ViewsContainer

+ (ViewsContainer*) sharedContainer
{
    static ViewsContainer* sharedInstance = nil;
    
    if (!sharedInstance)
        sharedInstance = [[ViewsContainer alloc] init];
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self)
        [self loadAllViews];
    
    return self;
}

- (void) loadAllViews
{
    MenuViewController* menuViewController = [[MenuViewController alloc] init];
    ShowViewController* showViewController = [[ShowViewController alloc] init];
    
    viewControllers = [[NSArray alloc] initWithObjects:
                       menuViewController,
                       showViewController, 
                       nil];
}

- (UIView*) viewOfType:(ViewType)viewType
{
    UIViewController* viewController = [viewControllers objectAtIndex:VT_MAIN_MENU];
    return viewController.view;
}

- (void) show:(ViewType)viewType fromView:(UIView*)view
{
    UIView* viewToShow = ((UIViewController*)[viewControllers objectAtIndex:viewType]).view;
    [self rotateNewView:viewToShow toOrientationOfView:view];
    
    [UIView transitionFromView:view toView:viewToShow 
                      duration:TRANSITION_DURATION 
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:nil];
}

#pragma mark - ViewsRotation

- (void) rotateNewView:(UIView*)newView toOrientationOfView:(UIView*)view
{
    UIView* currentView = nil;
    for (UIViewController* currentViewController in viewControllers)
    {
        if (currentViewController.view.superview)
        {
            currentView = currentViewController.view;
            break;
        }
    }
    [currentView removeFromSuperview];
    
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:newView];
    [newView removeFromSuperview];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:currentView];
}

@end
