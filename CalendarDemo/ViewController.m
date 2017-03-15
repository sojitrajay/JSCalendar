//
//  ViewController.m
//  CalendarDemo
//
//  Created by Jayesh Sojitra on 08/03/17.
//  Copyright © 2017 Jayesh Sojitra. All rights reserved.
//

#import "ViewController.h"
#import "EKEvent+JS.h"

@interface ViewController ()

@property (nonatomic,strong) NSString *savedEventId;
@property (nonatomic,strong) NSMutableArray *localCalendars;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.localCalendars = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionAddEvent:(UIButton *)sender {
    
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized) {
        EKEvent *event = [EKEvent createWithCalendar:[EKCalendar calendarRegistered]];
        event.title = @"Event Title";
        event.startDate = [NSDate date];
        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];
        NSError *err = nil;
        err = [EKEvent saveEvent:event span:EKSpanThisEvent commit:YES];
        self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
        NSLog(@"Event ID : %@",self.savedEventId);
    }
    else
    {
        [self createCalendarIfNotExist];
    }
}

- (IBAction)actionGetEvent:(id)sender {
    [self createCalendarIfNotExist];
}

-(void)createCalendarIfNotExist
{
    [JSEventStore requestCalendarWithCompletion:^(BOOL success, NSError *error) {
        if (success)
        {
            // Access granted go further.
            // Register custom calendar if you want to create one.
            [EKCalendar calendarRegistered];
        }
        else
        {
            NSLog(@"Error : %@",error.localizedDescription);
        }
    }];
}

@end
