//
//  EKCalendar+JS.h
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 09/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import <EventKit/EventKit.h>

@interface EKCalendar (JS)

+(instancetype)calendarRegistered;

+(instancetype)calendarWithName:(NSString*)calendarName;

@end
