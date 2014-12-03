//
//  DigestTest.m
//  kxutils
//
//  Created by Kolyvan on 28.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "KxDigest.h"
#import "NSData+KxUtils.h"

@interface DigestTest : XCTestCase

@end

@implementation DigestTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testMD5 {

    XCTAssert([[KxDigest md5DigestString:@""] isEqualToString:@"d41d8cd98f00b204e9800998ecf8427e"]);
    XCTAssert([[KxDigest md5DigestString:@"kolyvan"] isEqualToString:@"fa122c782999721c9e7b86298f07fe2e"]);
    
    NSData *data1 = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"kolyvan" dataUsingEncoding:NSUTF8StringEncoding];
    
    XCTAssert([[KxDigest md5DigestData:data1].toString isEqualToString:@"d41d8cd98f00b204e9800998ecf8427e"]);
    XCTAssert([[KxDigest md5DigestData:data2].toString isEqualToString:@"fa122c782999721c9e7b86298f07fe2e"]);
    
}

- (void)testSha1 {
    
    XCTAssert([[KxDigest sha1DigestString:@""] isEqualToString:@"da39a3ee5e6b4b0d3255bfef95601890afd80709"]);
    XCTAssert([[KxDigest sha1DigestString:@"kolyvan"] isEqualToString:@"4087878efaa125333074ff71c8b20a44f04335ef"]);
    
    NSData *data1 = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"kolyvan" dataUsingEncoding:NSUTF8StringEncoding];
    
    XCTAssert([[KxDigest sha1DigestData:data1].toString isEqualToString:@"da39a3ee5e6b4b0d3255bfef95601890afd80709"]);
    XCTAssert([[KxDigest sha1DigestData:data2].toString isEqualToString:@"4087878efaa125333074ff71c8b20a44f04335ef"]);
}

@end
