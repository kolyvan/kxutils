//
//  LinguisticTest.m
//  kxutils
//
//  Created by Kolyvan on 27.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "KxLinguistic.h"

@interface LinguisticTest : XCTestCase

@end

@implementation LinguisticTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLanguage {

    XCTAssertTrue([[KxLinguistic guessLanguage:@"hello"] isEqualToString:@"en"]);
    XCTAssertTrue([[KxLinguistic guessLanguage:@"привет"] isEqualToString:@"ru"]);
    XCTAssertTrue([[KxLinguistic guessLanguage:@"こんにちは"] isEqualToString:@"ja"]);
    XCTAssertTrue([[KxLinguistic guessLanguage:@"你好"] isEqualToString:@"zh-Hant"]);
}

- (void)testTokens {
    
    NSString *text = @"The quick brown fox jumps. Lorem ipsum dolor sit amet.";
    NSArray *words = @[@"The", @"quick", @"brown", @"fox", @"jumps", @"Lorem",  @"ipsum", @"dolor", @"sit",  @"amet"];
    NSArray *sentences = @[@"The quick brown fox jumps. ", @"Lorem ipsum dolor sit amet."];
    
    XCTAssertTrue([[KxLinguistic takeWords:text locale:nil] isEqualToArray:words]);
    XCTAssertTrue([[KxLinguistic takeSentences:text locale:nil] isEqualToArray:sentences]);
}

@end
