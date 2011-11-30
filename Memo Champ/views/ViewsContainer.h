//
//  ViewsContainer.h
//  Memo Champ
//
//  Created by Zbigniew Kominek on 11/30/11.
//  Copyright (c) 2011 Zbigniew Kominek. All rights reserved.
//

typedef enum
{
    VT_MAIN_MENU,
    VT_SHOW,
    SIZE_OF_VT
} ViewType;

@interface ViewsContainer : NSObject
{
@private
    NSArray* viewControllers;
}

+ (ViewsContainer*) sharedContainer;

- (void) loadAllViews;
- (UIView*) viewOfType:(ViewType)viewType;
- (void) show:(ViewType)viewType fromView:(UIView*)view;

@end
