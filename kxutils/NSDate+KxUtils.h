//
//  NSDate+KxUtils.h
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

#import <Foundation/Foundation.h>

@interface NSDate (KxUtils)

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;

@property (nonatomic, readonly) NSDateComponents * YMD;
@property (nonatomic, readonly) NSDateComponents * hms;
@property (nonatomic, readonly) NSDateComponents * YMDhms; // year, month, day, hour, minute, seconds
@property (nonatomic, readonly) NSDateComponents * YMDhms_GMT;

- (NSDate *) addSeconds:(NSInteger)seconds;
- (NSDate *) addMinutes:(NSInteger)minutes;
- (NSDate *) addHours:(NSInteger)hours;
- (NSDate *) addDays:(NSInteger)days;
- (NSDate *) addMonths:(NSInteger)months;
- (NSDate *) addYears:(NSInteger)years;

- (NSDate *) addYears:(NSInteger)years
               months:(NSInteger)months
                 days:(NSInteger)days
                hours:(NSInteger)hours
              minutes:(NSInteger)minutes
              seconds:(NSInteger)seconds;

- (NSDate *) midnight;
- (NSDate *) beginOfMonth;
- (NSDate *) endOfMonth;

- (BOOL) isSameDay:(NSDate *)other;
- (BOOL) isToday;
- (BOOL) isPast;
- (BOOL) isFuture;
- (BOOL) isYesterday;
- (BOOL) isTomorrow;

- (BOOL) isLess:(NSDate *)other;
- (BOOL) isGreater:(NSDate *)other;

- (NSInteger) daysBetweenDate:(NSDate *)other;
- (NSInteger) dayOfYear;

+ (NSDate *) yesterday;
+ (NSDate *) tomorrow;

+ (NSDate *) year:(NSUInteger)year
            month:(NSUInteger)month
              day:(NSUInteger)day
             hour:(NSUInteger)hour
           minute:(NSUInteger)minute
           second:(NSUInteger)second
         timeZone:(NSTimeZone *)tz;

+ (NSDate *) date:(NSDate *)date
             time:(NSDate *)time;

//// from string

+ (NSDate *) date:(NSString *)string
           format:(NSString *)format;

+ (NSDate *) date:(NSString *)string
           format:(NSString *)format
           locale:(NSLocale *)locale;

+ (NSDate *) date:(NSString *)string
           format:(NSString *)format
           locale:(NSLocale *)locale
         timeZone:(NSTimeZone *)tz;

+ (NSDate *) dateWithISO8601String:(NSString *)str;        // ISO8610 format, aka ATOM: yyyy-MM-dd'T'HH:mm:ssZZZ
+ (NSDate *) dateWithDateString:(NSString *)str;           // 'yyyy-MM-dd'
+ (NSDate *) dateWithDateTimeString:(NSString *)str;       // 'yyyy-MM-dd HH:mm:ss'
+ (NSDate *) dateWithLongDateTimeString:(NSString *)str;   // 'dd MMM yyyy HH:mm:ss'
+ (NSDate *) dateWithLongDateTimeString:(NSString *)str
                                 locale:(NSLocale *)locale;
+ (NSDate *) dateWithRSSDateString:(NSString *)str;        // RSS (RFC 822): 'EEE, d MMM yyyy HH:mm:ss ZZZ'
+ (NSDate *) dateWithAltRSSDateString:(NSString *)str;     // alternative RSS: 'd MMM yyyy HH:mm:ss ZZZ'
+ (NSDate *) dateWithHTTPDateString:(NSString *)str;


//// to string

- (NSString *)formattedDatePattern:(NSString *)datePattern;

- (NSString *) formattedDatePattern:(NSString *)datePattern
                           timeZone:(NSTimeZone *)tz;

- (NSString *) formattedDatePattern:(NSString *)datePattern
                           timeZone:(NSTimeZone *)tz
                             locale:(NSLocale *)locale;

- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle
                       timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSString *) formattedDateStyle:(NSDateFormatterStyle)dateStyle
                        timeStyle:(NSDateFormatterStyle)timeStyle
                         timeZone:(NSTimeZone *)tz;

- (NSString *) formattedDateStyle:(NSDateFormatterStyle)dateStyle
                        timeStyle:(NSDateFormatterStyle)timeStyle
                         timeZone:(NSTimeZone *) tz
                           locale:(NSLocale *)locale;

- (NSString *) iso8601Formatted; // ISO8601/ATOM: yyyy-MM-dd'T'HH:mm:ssZZZ
- (NSString *) dateFormatted;
- (NSString *) dateTimeFormatted;
- (NSString *) longDateTimeFormatted;
- (NSString *) longDateTimeFormatted:(NSLocale *)locale;
- (NSString *) RSSFormatted;
- (NSString *) AltRSSFormatted;

- (NSString *) dateTimeRelativeFormatted;

@end
