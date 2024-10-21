//
//  StartViewModel.h
//  EmployeeAttendance
//
//  Created by Ahd on 10/20/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Employee;

@interface StartViewModel : NSObject

@property (nonatomic, copy) NSString *welcomeMessage;
@property (nonatomic, copy) void (^didUpdateMessage)(void);

- (void)fetchMostRecentCheckInRecord;
- (void)handleCheckInWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
