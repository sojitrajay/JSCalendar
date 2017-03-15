//
//  EKCalendar+JS.m
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 09/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import "EKCalendar+JS.h"
#import "JSEventStore.h"
#import <UIKit/UIKit.h>

#define kCalendarName   @"Acuro"
#define kCalendarColor  [UIColor redColor].CGColor

@implementation EKCalendar (JS)

+(instancetype)calendarRegistered
{
    return [self calendarWithName:kCalendarName];
}

+(instancetype)calendarWithName:(NSString*)calendarName
{
    NSMutableArray *localCalendars = [[NSMutableArray alloc] init];
    
    NSArray *allCalendars = [[JSEventStore sharedEventStore] calendarsForEntityType:EKEntityTypeEvent];
    for (int i=0; i< [allCalendars count]; i++) {
        EKCalendar *currentCalendar = [allCalendars objectAtIndex:i];
        if (currentCalendar.allowsContentModifications)
        {
            [localCalendars addObject:currentCalendar];
        }
    }
    
    // Check if Acuro calendar is exist or not.
    NSPredicate *predicateCalendar = [NSPredicate predicateWithFormat:@"title == %@",calendarName];
    NSArray *arrayAcuroCal = [localCalendars filteredArrayUsingPredicate:predicateCalendar];

    // Else create Acuro calendar and return it.
    if (arrayAcuroCal.count) {
        return [arrayAcuroCal firstObject];
    }
    else{
        
        EKSource *theSource = nil;
        
        for (EKSource *source in [[JSEventStore sharedEventStore] sources]) {
            if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"]) {
                theSource = source;
                NSLog(@"iCloud Store Source");
                break;
            } else {
                for (EKSource *source in [[JSEventStore sharedEventStore] sources]) {
                    if (source.sourceType == EKSourceTypeLocal) {
                        theSource = source;
                        NSLog(@"ios Local Store Source");
                        break;
                    }
                }
            }
        }
        
        EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:[JSEventStore sharedEventStore]];
        calendar.title = calendarName;
        calendar.source = theSource;
        calendar.CGColor = kCalendarColor;
        
        // Create immediately.
        NSError *error = nil;
        if(![[JSEventStore sharedEventStore] saveCalendar:calendar commit:true error:&error])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //  "Error while creating calendar."
            });
            return nil;
        }
        return calendar;

    }

}

@end

