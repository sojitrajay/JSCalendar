//
//  EKEventStore+JS.m
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 09/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import "JSEventStore.h"

@implementation JSEventStore

+ (id)sharedEventStore
{
    static EKEventStore *sharedEventStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEventStore = [EKEventStore new];
    });
    return sharedEventStore;
}

+ (instancetype)registeredEventStore {
    return [self sharedEventStore];
}

+ (BOOL)isAccessAuthorized {
    return ([self authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized);
}

+ (BOOL)hasRegisteredEventStore {
    return ([self registeredEventStore] != nil);
}

+ (void)requestCalendarWithCompletion:(EKEventStoreCompletion)completion
{
    [[self sharedEventStore] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            completion(NO, error);
        }
        else
        {
            completion(YES,nil);
        }
    }];
}

@end
