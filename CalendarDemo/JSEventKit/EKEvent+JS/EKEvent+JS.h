//
//  EKEvent+JS.h
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 09/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import <EventKit/EventKit.h>

@interface EKEvent (JS)

+ (instancetype)createWithTitle:(NSString *)title
                         startDate:(NSDate *)startDate duration:(NSInteger)duration;

+ (instancetype)create;
+ (instancetype)createWithEventStore:(EKEventStore *)store forCalendar:(EKCalendar*)calendar;

+ (instancetype)createWithCalendar:(EKCalendar*)calendar;

+ (instancetype)eventWithID:(NSString *)identifier;

+ (NSError*)saveEvent:(EKEvent*)event span:(EKSpan)span commit:(BOOL)commit;

+ (NSArray *)eventsFrom:(NSDate *)from to:(NSDate *)to;

+ (NSError*)removeEventForEventIdentifier:(NSString*)identifier;

@end

