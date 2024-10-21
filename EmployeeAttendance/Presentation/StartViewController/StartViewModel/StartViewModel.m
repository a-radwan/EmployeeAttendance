//
//  StartViewModel.m
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

#import "StartViewModel.h"
#import "EmployeeAttendance-Swift.h"

@interface StartViewModel ()
@property (nonatomic, strong) Employee *employee;
@end

@implementation StartViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _welcomeMessage = @"Welcome!\n\n Press Start to check-in";
    }
    return self;
}

- (void)fetchMostRecentCheckInRecord {
    self.employee = [[CoreDataManager shared] fetchMostRecentCheckInRecord];
    
    if (self.employee != nil && self.employee.company.name != nil && self.employee.check_in_date_time != nil) {
        NSString *messageFormat = @"Welcome to %@!\n\nYour last check-in time is: %@";
        self.welcomeMessage = [NSString stringWithFormat:messageFormat, self.employee.company.name, self.employee.check_in_date_time];
    } else {
        self.welcomeMessage = @"Welcome!\n\nPress 'Start' to check in for the first time";
    }
    
    // Notify the view controller about the update
    if (self.didUpdateMessage) {
        self.didUpdateMessage();
    }
}

- (void)handleCheckInWithDate:(NSDate *)date {

    [self fetchMostRecentCheckInRecord];
}

@end
