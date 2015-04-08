//
//  NSDate+KxUtils.m
//  https://github.com/kolyvan/kxutils
//
//  Created by Kolyvan on 28.11.14.

/*
 Copyright (c) 2014 Konstantin Bukreev All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 - Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "NSDate+KxUtils.h"

#define YMD_COMPONENTS NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear
#define HMS_COMPONENTS NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitHour
#define YMDHMS_COMPONENTS YMD_COMPONENTS|HMS_COMPONENTS|NSCalendarUnitWeekday

@implementation NSDate (KxUtils)

- (NSDateComponents *) YMD
{
    return [[NSCalendar currentCalendar] components:YMD_COMPONENTS fromDate:self];
}

- (NSDateComponents *) hms
{
    return [[NSCalendar currentCalendar] components:HMS_COMPONENTS fromDate:self];
}

- (NSDateComponents *) YMDhms
{
    return [[NSCalendar currentCalendar] components:YMDHMS_COMPONENTS fromDate:self];
}

- (NSDateComponents *) YMDhms_GMT
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDateComponents *dc = [calendar components:YMDHMS_COMPONENTS fromDate:self];
    return dc;
}

- (NSInteger) year
{
    return self.YMDhms.year;
}

- (NSInteger) month
{
    return self.YMDhms.month;
}

- (NSInteger) day
{
    return self.YMDhms.day;
}

- (NSInteger) hour
{
    return self.YMDhms.hour;
}

- (NSInteger) minute
{
    return self.YMDhms.minute;
}

- (NSInteger) second
{
    return self.YMDhms.second;
}

- (NSDate *) addSeconds:(NSInteger) seconds
{
    return [self addYears:0 months:0 days:0 hours:0 minutes:0 seconds:seconds];
}

- (NSDate *) addMinutes:(NSInteger) minutes
{
    return [self addYears:0 months:0 days:0 hours:0 minutes:minutes seconds:0];
}

- (NSDate *) addHours:(NSInteger) hours
{
    return [self addYears:0 months:0 days:0 hours:hours minutes:0 seconds:0];
}

- (NSDate *) addDays: (NSInteger)days
{
    return [self addYears:0 months:0 days:days hours:0 minutes:0 seconds:0];
}

- (NSDate *) addMonths:(NSInteger) months
{
    return [self addYears:0 months:months days:0 hours:0 minutes:0 seconds:0];
}

- (NSDate *) addYears:(NSInteger) years
{
    return [self addYears:years months:0 days:0 hours:0 minutes:0 seconds:0];
}

- (NSDate *) addYears:(NSInteger) years
               months:(NSInteger) months
                 days:(NSInteger) days
                hours:(NSInteger) hours
              minutes:(NSInteger) minutes
              seconds:(NSInteger) seconds
{
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    dc.year = years;
    dc.month = months;
    dc.day = days;
    dc.hour = hours;
    dc.minute = minutes;
    dc.second = seconds;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:self options:0];
}

- (NSDate *) midnight
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *ymd = [calendar components:YMD_COMPONENTS fromDate:self];
    return [calendar dateFromComponents:ymd];
}

- (NSDate *) beginOfMonth
{
    NSDateComponents *comp = self.YMDhms_GMT;
    return [NSDate year:comp.year
                  month:comp.month
                    day:1
                   hour:0
                 minute:0
                 second:0
               timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
}

- (NSDate *) endOfMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    const NSRange daysRange = [cal rangeOfUnit:NSCalendarUnitDay
                                        inUnit:NSCalendarUnitMonth
                                       forDate:self];
    
    NSDateComponents *comp = self.YMDhms_GMT;
    return [NSDate year:comp.year
                  month:comp.month
                    day:daysRange.length
                   hour:23
                 minute:59
                 second:59
               timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
}

- (BOOL) isSameDay:(NSDate *)other
{
    NSDateComponents *l = self.YMDhms;
    NSDateComponents *r = other.YMDhms;
    
    return l.year == r.year && l.month == r.month && l.day == r.day;
}

- (BOOL) isToday
{
    return [self isSameDay:[NSDate date]];
}

- (BOOL) isYesterday
{
    return [self isSameDay:[NSDate yesterday]];
}

- (BOOL) isTomorrow
{
    return [self isSameDay:[NSDate tomorrow]];
}

- (BOOL) isPast
{
    return [self isLess:[NSDate date]];
}

- (BOOL) isFuture
{
    return [self isGreater:[NSDate date]];
}

- (BOOL) isLess: (NSDate *) other
{
    return [self compare:other] == NSOrderedAscending;
}

- (BOOL) isGreater: (NSDate *) other
{
    return [self compare:other] == NSOrderedDescending;
}

- (NSInteger) daysBetweenDate:(NSDate *) other;
{
    NSDateComponents *dc = [[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                           fromDate:self
                                                             toDate:other
                                                            options:0]; // NSWrapCalendarComponents?
    return dc.day;
    
    //NSTimeInterval seconds = [other timeIntervalSinceDate:self];
    //return round(seconds / 86400);
}

- (NSInteger) dayOfYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                   inUnit:NSCalendarUnitYear
                                                  forDate:self];
}

#pragma mark - factory

+ (NSDate *) yesterday
{
    return [[NSDate date] addDays:-1];
}

+ (NSDate *) tomorrow
{
    return [[NSDate date] addDays:+1];
}

+ (NSDate *) year:(NSUInteger) year
            month:(NSUInteger) month
              day:(NSUInteger) day
             hour:(NSUInteger) hour
           minute:(NSUInteger) minute
           second:(NSUInteger) second
         timeZone:(NSTimeZone *) timeZone;
{
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    dc.year = year;
    dc.month = month;
    dc.day = day;
    dc.hour = hour;
    dc.minute = minute;
    dc.second = second;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if (timeZone) {
        calendar.timeZone = timeZone;
    }
    return [calendar dateFromComponents:dc];
}

+ (NSDate *) date:(NSDate *)date
             time:(NSDate *)time
{
    NSDateComponents *dc = [date YMDhms];
    NSDateComponents *tc = [time hms];
    
    return [self year:dc.year
                month:dc.month
                  day:dc.day
                 hour:tc.hour
               minute:tc.minute
               second:tc.second
             timeZone:nil];
}

+ (NSDate *) date:(NSString *)string
           format:(NSString *)format
{
    return [self date:string
               format:format
               locale:nil
             timeZone:nil];
}

+ (NSDate *) date:(NSString *)string
           format:(NSString *)format
           locale:(NSLocale *)locale
{
    return [self date:string
               format:format
               locale:locale
             timeZone:nil];
}

+ (NSDate *) date:(NSString *)string
           format:(NSString *)format
           locale:(NSLocale *)locale
         timeZone:(NSTimeZone *)tz
{
    if (!string) {
        return nil;
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    if (locale) {
        [formatter setLocale:locale];
    }
    
    if (tz) {
        [formatter setTimeZone:tz];
    }
    
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:string];
}

+ (NSDate *) dateWithISO8601String:(NSString *) string
{
    if (!string) {
        return nil;
    }
    
    if([string hasSuffix:@" 00:00"]) {
        string = [[string substringToIndex:(string.length-6)] stringByAppendingString:@"GMT"];
    } else if ([string hasSuffix:@"Z"]) {
        string = [[string substringToIndex:(string.length-1)] stringByAppendingString:@"GMT"];
    }
    
    return [NSDate date:string
                 format:@"yyyy-MM-dd'T'HH:mm:ssZZZ"
                 locale:nil];
}

+ (NSDate *) dateWithDateString:(NSString *) string
{
    return [NSDate date:string
                 format:@"yyyy-MM-dd"
                 locale:nil];
}

+ (NSDate *) dateWithDateTimeString:(NSString *) string
{
    return [NSDate date:string
                 format:@"yyyy-MM-dd HH:mm:ss"
                 locale:nil];
}

+ (NSDate *) dateWithLongDateTimeString:(NSString *) string
{
    return [self dateWithLongDateTimeString:string
                                     locale:nil];
}

+ (NSDate *) dateWithLongDateTimeString:(NSString *) string
                                 locale:(NSLocale *)locale
{
    return [NSDate date:string
                 format:@"dd MMM yyyy HH:mm:ss"
                 locale:locale];
}

+ (NSDate *) dateWithRSSDateString:(NSString *) string
{
    if ([string hasSuffix:@"Z"]) {
        string = [[string substringToIndex:(string.length-1)] stringByAppendingString:@"GMT"];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [NSDate date:string format:@"EEE, d MMM yyyy HH:mm:ss ZZZ" locale:locale];
}

+ (NSDate *) dateWithAltRSSDateString:(NSString *) string
{
    if ([string hasSuffix:@"Z"]) {
        string = [[string substringToIndex:(string.length-1)] stringByAppendingString:@"GMT"];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [NSDate date:string
                 format:@"d MMM yyyy HH:mm:ss ZZZ"
                 locale:locale];
}

+ (NSDate *) dateWithHTTPDateString:(NSString *) string
{
    // http://www.w3.org/Protocols/rfc2616/rfc2616-sec3.html#sec3.3.1
    // Sun, 06 Nov 1994 08:49:37 GMT  ; RFC 822, updated by RFC 1123
    // Sunday, 06-Nov-94 08:49:37 GMT ; RFC 850, obsoleted by RFC 1036
    // Sun Nov  6 08:49:37 1994       ; ANSI C's asctime() format
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *result;
    
    result = [NSDate date:string format:@"EEE, d MMM yyyy HH:mm:ss zzz" locale:locale];
    if (!result) {
        result = [NSDate date:string format:@"EEEE, d-MMM-yy HH:mm:ss zzz" locale:locale];
        if (!result) {
            result = [NSDate date:string format:@"EEE MMM d HH:mm:ss yyyy" locale:locale];
        }
    }
    return result;
}

#pragma mark - to strings

- (NSString *)formattedDatePattern:(NSString *) datePattern
{
    return [self formattedDatePattern:datePattern
                             timeZone:nil
                               locale:nil];
}

- (NSString *)formattedDatePattern:(NSString *) datePattern
                          timeZone:(NSTimeZone *) tz;
{
    return [self formattedDatePattern:datePattern
                             timeZone:tz
                               locale:nil];
}

- (NSString *)formattedDatePattern:(NSString *) datePattern
                          timeZone:(NSTimeZone *) tz
                            locale:(NSLocale *)locale;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:datePattern];
    if (locale) {
        [formatter setLocale:locale];
    }
    if (tz) {
        [formatter setTimeZone:tz];
    }
    return [formatter stringFromDate:self];
}

- (NSString *)formattedDateStyle:(NSDateFormatterStyle) dateStyle
                       timeStyle:(NSDateFormatterStyle) timeStyle
{
    return [self formattedDateStyle:dateStyle
                          timeStyle:timeStyle
                           timeZone:nil
                             locale:nil];
}

- (NSString *)formattedDateStyle:(NSDateFormatterStyle) dateStyle
                       timeStyle:(NSDateFormatterStyle) timeStyle
                        timeZone:(NSTimeZone *) tz
{
    return [self formattedDateStyle:dateStyle
                          timeStyle:timeStyle
                           timeZone:tz
                             locale:nil];
}

- (NSString *)formattedDateStyle:(NSDateFormatterStyle) dateStyle
                       timeStyle:(NSDateFormatterStyle) timeStyle
                        timeZone:(NSTimeZone *) tz
                         locale :(NSLocale *)locale;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];
    if (locale) {
        [formatter setLocale:locale];
    }
    if (tz) {
        [formatter setTimeZone:tz];
    }
    return [formatter stringFromDate:self];
}

- (NSString *) iso8601Formatted
{
    return [self formattedDatePattern:@"yyyy-MM-dd'T'HH:mm:ssZ"];
}

- (NSString *) dateFormatted
{
    return [self formattedDatePattern:@"yyyy-MM-dd"];
}

- (NSString *) dateTimeFormatted
{
    return [self formattedDatePattern:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *) longDateTimeFormatted
{
    return [self longDateTimeFormatted:nil];
}

- (NSString *) longDateTimeFormatted:(NSLocale *)locale
{
    return [self formattedDatePattern:@"dd MMM yyyy HH:mm:ss" timeZone:nil locale:locale];
}

- (NSString *) RSSFormatted
{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [self formattedDatePattern:@"EEE, d MMM yyyy HH:mm:ss ZZZ"
                             timeZone:nil
                               locale:locale];
}

- (NSString *) AltRSSFormatted
{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [self formattedDatePattern:@"d MMM yyyy HH:mm:ss ZZZ"
                             timeZone:nil
                               locale:locale];
}

- (NSString *) dateTimeRelativeFormatted
{
    if ([self isToday]) {
        return [self formattedDatePattern:@"HH:mm"];
    }
    
    if (self.year == [NSDate date].year) {
        return [self formattedDatePattern:@"dd MMM."];
    }
    
    return [self formattedDatePattern:@"yyyy-MM-dd"];
}

@end
