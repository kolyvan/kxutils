//
//  NSStringTest.m
//  kxutils
//
//  Created by Kolyvan on 27.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+KxUtils.h"

@interface NSStringTest : XCTestCase

@end

@implementation NSStringTest

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFactory {
    
    NSString *uuid1 = [NSString uniqueString];
    NSString *uuid2 = [NSString uniqueString];
    NSString *rstring = [NSString randomAsciiString:7];
    
    XCTAssert(uuid1.length > 0, @"Pass");
    XCTAssertFalse([uuid1 isEqualToString:uuid2], @"Pass");
    XCTAssert(rstring.length == 7, @"Pass");
}

- (void)testIsXXXCase {
 
    XCTAssertTrue([@"" isLowercase], @"Pass");
    XCTAssertTrue([@"" isUppercase], @"Pass");
    
    XCTAssertTrue([@"abcde" isLowercase], @"Pass");
    XCTAssertTrue([@"абвгд" isLowercase], @"Pass");
    XCTAssertTrue([@"ABCDE" isUppercase], @"Pass");
    XCTAssertTrue([@"АБВГД" isUppercase], @"Pass");
    
    XCTAssertFalse([@"aBCDe" isLowercase], @"Pass");
    XCTAssertFalse([@"ABCDE" isLowercase], @"Pass");
    XCTAssertFalse([@"аБВГд" isLowercase], @"Pass");
    XCTAssertFalse([@"АБВГД" isLowercase], @"Pass");
    XCTAssertFalse([@"abcde" isUppercase], @"Pass");
    XCTAssertFalse([@"aBCDe" isUppercase], @"Pass");
    XCTAssertFalse([@"абвгд" isUppercase], @"Pass");
    XCTAssertFalse([@"аБВГд" isUppercase], @"Pass");
}

- (void)testTrimmed {
    
    XCTAssertTrue([[@"" trimmed] isEqualToString:@""], @"Pass");
    XCTAssertTrue([[@"" trimmedHead] isEqualToString:@""], @"Pass");
    XCTAssertTrue([[@"" trimmedTail] isEqualToString:@""], @"Pass");
    
    XCTAssertTrue([[@" \n abc\n \n" trimmed] isEqualToString:@"abc"], @"Pass");
    XCTAssertTrue([[@" \n абв\n \n" trimmed] isEqualToString:@"абв"], @"Pass");
    
    XCTAssertTrue([[@" \n abc\n \n" trimmedHead] isEqualToString:@"abc\n \n"], @"Pass");
    XCTAssertTrue([[@" \n абв\n \n" trimmedHead] isEqualToString:@"абв\n \n"], @"Pass");
    
    XCTAssertTrue([[@" \n abc\n \n" trimmedTail] isEqualToString:@" \n abc"], @"Pass");
    XCTAssertTrue([[@" \n абв\n \n" trimmedTail] isEqualToString:@" \n абв"], @"Pass");
}

- (void) testHTTP {

    XCTAssertTrue([[@"example.com" stringByDeletingHTTPScheme] isEqualToString:@"example.com"], @"Pass");
    XCTAssertTrue([[@"http://example.com" stringByDeletingHTTPScheme] isEqualToString:@"example.com"], @"Pass");
    XCTAssertTrue([[@"https://example.com" stringByDeletingHTTPScheme] isEqualToString:@"example.com"], @"Pass");
    
    XCTAssertTrue([[@"example.com" stringByDeletingTrailingSlash] isEqualToString:@"example.com"], @"Pass");
    XCTAssertTrue([[@"example.com/" stringByDeletingTrailingSlash] isEqualToString:@"example.com"], @"Pass");
    
}

- (void) testStripHTML {

    XCTAssertTrue([[@"" stripHTML:NO] isEqualToString:@""], @"Pass");
    XCTAssertTrue([[@"foo" stripHTML:NO] isEqualToString:@"foo"], @"Pass");
    XCTAssertTrue([[@"<br />" stripHTML:NO] isEqualToString:@""], @"Pass");
    XCTAssertTrue([[@"<div>foo</div>" stripHTML:NO] isEqualToString:@"foo"], @"Pass");
    XCTAssertTrue([[@"<br />foo" stripHTML:NO] isEqualToString:@"foo"], @"Pass");
    XCTAssertTrue([[@"foo<br />" stripHTML:NO] isEqualToString:@"foo"], @"Pass");
    XCTAssertTrue([[@"abc<div>123<span><b>+</b></span></div>456<br />def" stripHTML:NO] isEqualToString:@"abc123+456def"], @"Pass");
    
    XCTAssertTrue([[@"<br>" stripHTML:YES] isEqualToString:@"\n"], @"Pass");
    XCTAssertTrue([[@"<br />" stripHTML:YES] isEqualToString:@"\n"], @"Pass");
    XCTAssertTrue([[@"<br />foo" stripHTML:YES] isEqualToString:@"\nfoo"], @"Pass");
    XCTAssertTrue([[@"foo<br />" stripHTML:YES] isEqualToString:@"foo\n"], @"Pass");
    XCTAssertTrue([[@"<div>foo</div>" stripHTML:YES] isEqualToString:@"\nfoo"], @"Pass");    
    XCTAssertTrue([[@"abc<div>123<span><b>+</b></span></div>456<br />def" stripHTML:YES] isEqualToString:@"abc\n123+456\ndef"], @"Pass");
}

- (void) testLevenshtein {
    
    XCTAssert(0 == [@"abcd" levenshteinDistance:@"abcd"]);
    XCTAssert(1 == [@"abcd" levenshteinDistance:@"1abcd"]);
    XCTAssert(2 == [@"abcd" levenshteinDistance:@"1abc2"]);
}

- (void) testScore {

    NSString *str = @"Hello World";
    
    XCTAssert(0. == [str scoreAgainst:nil]);
    XCTAssert(1. == [str scoreAgainst:str]);
    XCTAssert(0. == [str scoreAgainst:@"Hellx"]);
    XCTAssert(0. == [str scoreAgainst:@"Hello_World"]);
    XCTAssert(0. == [str scoreAgainst:@"WH"]);
    XCTAssert(0. <  [str scoreAgainst:@"H"]);
    XCTAssert(0. <  [str scoreAgainst:@"h"]);
    XCTAssert(0. <  [str scoreAgainst:@"e"]);
    XCTAssert(0. <  [str scoreAgainst:@"W"]);
    XCTAssert(0. <  [str scoreAgainst:@"World"]);
    XCTAssert(0. <  [str scoreAgainst:@"world"]);
    XCTAssert([str scoreAgainst:@"hello"] < [str scoreAgainst:@"Hello"]);
    XCTAssert([str scoreAgainst:@"H"] < [str scoreAgainst:@"He"]);

    XCTAssert([str scoreAgainst:@"e"] < [str scoreAgainst:@"h"]);
    XCTAssert([str scoreAgainst:@"h"] < [str scoreAgainst:@"he"]);
    XCTAssert([str scoreAgainst:@"hel"] < [str scoreAgainst:@"hell"]);
    XCTAssert([str scoreAgainst:@"hell"] < [str scoreAgainst:@"hello"]);
    XCTAssert([str scoreAgainst:@"hello"] < [str scoreAgainst:@"helloworld"]);
    XCTAssert([str scoreAgainst:@"helloworl"] < [str scoreAgainst:@"hello worl"]);
    XCTAssert([str scoreAgainst:@"hello worl"] < [str scoreAgainst:@"hello world"]);
    
    XCTAssert([str scoreAgainst:@"Hld"] < [str scoreAgainst:@"Hel"]);
    XCTAssert([str scoreAgainst:@"w"] < [str scoreAgainst:@"h"]);
}

- (void) testScoreFuzzy {
    
    NSString *str = @"Hello World";

    XCTAssert(0. <  [str scoreAgainst:@"Hz" fuzziness:0.5]);
    XCTAssert(0. <  [str scoreAgainst:@"jello" fuzziness:0.5]);
    XCTAssert([str scoreAgainst:@"hello wor1" fuzziness:0.5] < [str scoreAgainst:@"hello worl" fuzziness:0.5]);
    XCTAssert([str scoreAgainst:@"Hz" fuzziness:0.5] < [str scoreAgainst:@"Hz" fuzziness:0.9]);
}

/*
- (void)testPerformanceExample {
 
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/

@end
