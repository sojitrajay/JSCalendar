//
//  AppDelegate.h
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 08/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;


@end

