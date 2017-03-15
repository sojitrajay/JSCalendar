//
//  EKEventStore+JS.h
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 09/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import <EventKit/EventKit.h>

typedef void (^EKEventStoreCompletion)(BOOL success, NSError *error);

@interface JSEventStore : EKEventStore

+ (id)sharedEventStore;

+ (BOOL)isAccessAuthorized;
+ (BOOL)hasRegisteredEventStore;

+ (void)requestCalendarWithCompletion:(EKEventStoreCompletion)completion;

@end
