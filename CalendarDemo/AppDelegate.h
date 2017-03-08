//
//  AppDelegate.h
//  CalendarDemo
//
//  Created by bosleo8 on 08/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

