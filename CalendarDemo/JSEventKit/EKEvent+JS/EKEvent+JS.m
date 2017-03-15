//
//  EKEvent+JS.m
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 09/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import "EKEvent+JS.h"
#import "JSEventStore.h"
#import "EKCalendar+JS.h"

@implementation EKEvent (JS)

+ (instancetype)createWithTitle:(NSString *)title
                         startDate:(NSDate *)startDate duration:(NSInteger)duration {
    EKEvent *event = [self create];
    event.calendar = [[JSEventStore sharedEventStore] defaultCalendarForNewEvents];
    event.startDate = startDate;
    event.endDate = [startDate dateByAddingTimeInterval:60*60];
    event.title = title;
    return event;
}

+ (instancetype)create {
    return [self createWithEventStore:[JSEventStore sharedEventStore] forCalendar:[[JSEventStore sharedEventStore] defaultCalendarForNewEvents]];
}

+ (instancetype)createWithEventStore:(EKEventStore *)store forCalendar:(EKCalendar*)calendar{
    EKEvent *event = [self eventWithEventStore:store];
    event.calendar = calendar;
    return event;
}

+ (instancetype)createWithCalendar:(EKCalendar*)calendar {
    return [self createWithEventStore:[JSEventStore sharedEventStore] forCalendar:calendar];
}

+ (NSError*)saveEvent:(EKEvent*)event span:(EKSpan)span commit:(BOOL)commit
{
    NSError *error = nil;
    [[JSEventStore sharedEventStore] saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
    return error;
}

+ (instancetype)eventWithID:(NSString *)identifier {
    return [[JSEventStore sharedEventStore] eventWithIdentifier:identifier];
}

+ (NSArray *)eventsFrom:(NSDate *)from to:(NSDate *)to {
    id store = [JSEventStore sharedEventStore];
    id predicate = [store predicateForEventsWithStartDate:from endDate:to calendars:nil];
    id events = [[JSEventStore sharedEventStore] eventsMatchingPredicate:predicate];
    events = [events sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    return events;
}

+ (NSError*)removeEventForEventIdentifier:(NSString*)identifier
{
    NSError *error = nil;
    EKEvent *event = [[JSEventStore sharedEventStore] eventWithIdentifier:identifier];
    if([event.eventIdentifier isEqualToString: identifier]
       && ![[JSEventStore sharedEventStore] removeEvent:event span:EKSpanThisEvent commit:YES error:&error])
    {
        NSLog(@"Error in removing event: %@",error);
        return error;
    }
    return nil;
}

@end
