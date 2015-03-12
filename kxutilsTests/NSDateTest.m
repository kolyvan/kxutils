//
//  NSDateTest.m
//  kxutils
//
//  Created by Kolyvan on 28.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDate+KxUtils.h"

@interface NSDateTest : XCTestCase

@end

@implementation NSDateTest {
    
    NSDate *_today;
    NSDate *_foolsDay;
}

- (void)setUp {
    [super setUp];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _foolsDay = [formatter dateFromString:@"2014-04-01 07:42:21"];
    
    _today = [NSDate date];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPropertites {

    XCTAssert(YES, @"Pass");
    
    XCTAssertTrue(_foolsDay.year ==  2014);
    XCTAssertTrue(_foolsDay.month == 4);
    XCTAssertTrue(_foolsDay.day == 1);
    XCTAssertTrue(_foolsDay.hour == 7);
    XCTAssertTrue(_foolsDay.minute == 42);
    XCTAssertTrue(_foolsDay.second ==  21);
}

- (void) testIsDate {
    
    XCTAssertFalse([_foolsDay isSameDay:_today]);
    XCTAssertTrue([_today isSameDay:[NSDate date]]);
    
    XCTAssertFalse([_foolsDay isToday]);
    XCTAssertTrue([_foolsDay isPast]);
    XCTAssertFalse([_foolsDay isFuture]);
    
    XCTAssertFalse([[NSDate distantFuture] isPast]);
    XCTAssertTrue([[NSDate distantPast] isPast]);
    XCTAssertTrue([[NSDate distantFuture] isFuture]);
    XCTAssertFalse([[NSDate distantPast] isFuture]);
    
    XCTAssertFalse([_today isYesterday]);
    XCTAssertTrue([_today isToday]);
    XCTAssertFalse([_today isTomorrow]);
    
    XCTAssertTrue([[NSDate yesterday] isYesterday]);
    XCTAssertFalse([[NSDate yesterday] isToday]);
    XCTAssertFalse([[NSDate yesterday] isTomorrow]);
    
    XCTAssertFalse([[NSDate tomorrow] isYesterday]);
    XCTAssertFalse([[NSDate tomorrow] isToday]);
    XCTAssertTrue([[NSDate tomorrow] isTomorrow]);
}

- (void) testFactory {

    NSDate *td = [NSDate year:[_foolsDay year]
                        month:[_foolsDay month]
                          day:[_foolsDay day]
                         hour:[_foolsDay hour]
                       minute:[_foolsDay minute]
                       second:[_foolsDay second]
                     timeZone:nil];
    
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertFalse([td isEqualToDate:_today]);
    
    td = [NSDate dateWithISO8601String:[_foolsDay iso8601Formatted]];
    
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertFalse([td isEqualToDate:_today]);
    
    td = [NSDate dateWithDateTimeString:[_foolsDay dateTimeFormatted]];
    
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertFalse([td isEqualToDate:_today]);
    
    td = [NSDate dateWithLongDateTimeString:[_foolsDay longDateTimeFormatted]];
    
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertFalse([td isEqualToDate:_today]);
    
    td = [NSDate dateWithRSSDateString:[_foolsDay RSSFormatted]];
    
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertFalse([td isEqualToDate:_today]);
    
    td = [NSDate dateWithAltRSSDateString:[_foolsDay AltRSSFormatted]];
    
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertFalse([td isEqualToDate:_today]);
}

- (void) testLocale {
    
    NSDate *td;
    
    NSLocale *enUS = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSLocale *ruRU = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    
    td = [NSDate dateWithLongDateTimeString:@"01 Apr 2014 07:42:21" locale:enUS];
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertTrue([[td longDateTimeFormatted:enUS] isEqualToString:@"01 Apr 2014 07:42:21"]);
    
    td = [NSDate dateWithLongDateTimeString:@"01 апр. 2014 07:42:21" locale:ruRU];
    XCTAssertTrue([td isEqualToDate:_foolsDay]);
    XCTAssertTrue([[td longDateTimeFormatted:ruRU] isEqualToString:@"01 апр. 2014 07:42:21"]);
}

- (void) testAdd {

    XCTAssertTrue([_foolsDay addSeconds:5].second == (_foolsDay.second + 5));
    XCTAssertTrue([_foolsDay addMinutes:5].minute == (_foolsDay.minute + 5));
    XCTAssertTrue([_foolsDay addHours:5].hour == (_foolsDay.hour + 5));
    XCTAssertTrue([_foolsDay addDays:5].day == (_foolsDay.day + 5));
    XCTAssertTrue([_foolsDay addMonths:5].month == (_foolsDay.month + 5));
    XCTAssertTrue([_foolsDay addYears:5].year == (_foolsDay.year + 5));
}

- (void) testMidnight {
    
    XCTAssertTrue([_foolsDay isSameDay:_foolsDay.midnight]);
    XCTAssertTrue(_foolsDay.midnight.hour == 0);
    XCTAssertTrue(_foolsDay.midnight.minute == 0);
    XCTAssertTrue(_foolsDay.midnight.second == 0);
}

- (void) testMonth {

    XCTAssertTrue(_today.beginOfMonth.YMDhms_GMT.day == 1);
    XCTAssertTrue(_today.beginOfMonth.YMDhms_GMT.month == _today.YMDhms_GMT.month);
    XCTAssertTrue(_today.endOfMonth.YMDhms_GMT.month == _today.YMDhms_GMT.month);

    XCTAssertTrue(_foolsDay.beginOfMonth.YMDhms_GMT.day == 1);
    XCTAssertTrue(_foolsDay.endOfMonth.YMDhms_GMT.day == 30);
    XCTAssertTrue(_foolsDay.beginOfMonth.YMDhms_GMT.month == 3);
    XCTAssertTrue(_foolsDay.endOfMonth.YMDhms_GMT.month == 3);
}

- (void) testDaysBetween {
    
    XCTAssertTrue([_foolsDay daysBetweenDate:[_foolsDay addDays:+40]] == 40);
    XCTAssertTrue([_foolsDay daysBetweenDate:[_foolsDay addDays:-40]] == -40);
}

- (void) testDayOfYear {
    
    XCTAssertTrue([_foolsDay dayOfYear] == 91);
}


- (void) testHttpDate {

    // @"Sun, 06 Nov 1994 08:49:37 GMT"
    NSDate *date = [NSDate year:1994 month:11 day:6 hour:8 minute:49 second:37
                       timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate * td;
    td = [NSDate dateWithHTTPDateString:@"Sun, 06 Nov 1994 08:49:37 GMT"];
    XCTAssertTrue([td isEqualToDate:date]);
    
    td = [NSDate dateWithHTTPDateString:@"Sunday, 06-Nov-94 08:49:37 GMT"];
    XCTAssertTrue([td isEqualToDate:date]);
    
    date = [NSDate year:1994 month:11 day:6 hour:8 minute:49 second:37
               timeZone:[NSTimeZone localTimeZone]];
    
    td = [NSDate dateWithHTTPDateString:@"Sun Nov  6 08:49:37 1994"];
    XCTAssertTrue([td isEqualToDate:date]);

}

- (void)testGMT {
    
    NSDate *td = [NSDate dateWithAltRSSDateString:@"1 Apr 2014 07:42:21 GMT"];
    NSDateComponents *dc = td.YMDhms_GMT;
    
    XCTAssertTrue(dc.year ==  2014);
    XCTAssertTrue(dc.month == 4);
    XCTAssertTrue(dc.day == 1);
    XCTAssertTrue(dc.hour == 7);
    XCTAssertTrue(dc.minute == 42);
    XCTAssertTrue(dc.second ==  21);
}

- (void) testCompare {

    XCTAssertTrue([_today isLess:[_today addDays:+1]]);
    XCTAssertFalse([_today isLess:[_today addDays:-1]]);
    XCTAssertFalse([_today isGreater:[_today addDays:+1]]);
    XCTAssertTrue([_today isGreater:[_today addDays:-1]]);
}

@end
