//
//  FilePathTest.m
//  kxutils
//
//  Created by Kolyvan on 27.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "KxFilePath.h"

@interface FilePathTest : XCTestCase

@end

@implementation FilePathTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEscape {

    NSString *path = @"/test?/:one";
    NSString *escaped = @"%2Ftest%3F%2F%3Aone";
    
    XCTAssertTrue([[KxFilePath escapePath:path] isEqualToString:escaped]);
    XCTAssertTrue([[KxFilePath unescapePath:escaped] isEqualToString:path]);
}

- (void)testDuplicate {

    XCTAssertTrue([[KxFilePath duplicatePath:@"/docs/test" index:42] isEqualToString:@"/docs/test_42"]);
    XCTAssertTrue([[KxFilePath duplicatePath:@"/docs/test.json" index:42] isEqualToString:@"/docs/test_42.json"]);
}

@end
