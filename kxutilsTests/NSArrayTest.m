//
//  NSArrayTest.m
//  kxutils
//
//  Created by Kolyvan on 28.11.14.
//  Copyright (c) 2014 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSArray+KxUtils.h"

@interface NSArrayTest : XCTestCase

@end

@implementation NSArrayTest {
    
    NSArray *_array;
}

- (void)setUp {
    [super setUp];
    
    _array = @[@"primum", @"secundo", @"tertia", @"", @"finem"];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSubarray {
    
    NSArray *tail  = @[@"secundo", @"tertia", @"", @"finem"];
    NSArray *take3 = @[@"primum", @"secundo", @"tertia"];
    NSArray *drop2 = @[@"tertia", @"", @"finem"];
    
    XCTAssertTrue([_array.tail isEqualToArray:tail]);
    XCTAssertTrue([[_array take: 3] isEqualToArray:take3]);
    XCTAssertTrue([[_array drop: 2] isEqualToArray:drop2]);
}

- (void)testSorted {
    
    NSArray *sorted = @[@"", @"finem", @"primum", @"secundo", @"tertia"];
    XCTAssertTrue([_array.sorted isEqualToArray:sorted]);
}

- (void) testReverse {

    NSArray *reverse = @[@"finem", @"", @"tertia", @"secundo", @"primum"];
    XCTAssertTrue([_array.reverse isEqualToArray:reverse]);
}

- (void) testMap {
    
    NSArray *lengths = @[@(6), @(7), @(6), @(0), @(5)];
    XCTAssertTrue([[_array map:^(id x) { return @([x length]); }] isEqualToArray:lengths]);
    
    NSArray *a = @[@[@"1", @"2"], @[], @[@"4", @"5"]];
    NSArray *flatMap = @[@"1", @"2", @"4", @"5"];
    
    XCTAssertTrue([[a flatMap:^(id x) { return x; }] isEqualToArray:flatMap]);
}

- (void) testReduce {

    NSString *reduce = [_array reduce:^id(id acc, id x) {
        return [x length] ? [NSString stringWithFormat:@"%@,%@", acc, x] : acc;
    }];
    
    XCTAssertTrue([reduce isEqualToString:@"primum,secundo,tertia,finem"]);
    
    NSNumber *fold = [_array fold:@(1)
                             with:^(id acc, id x)
    {
        return @(((NSNumber *)acc).integerValue + [x length]);
    }];
    
    XCTAssertTrue(fold.integerValue == 25);
    
}

- (void) testFilter {

    NSArray *filter = [_array filterNot:^BOOL(id x) { return [x length] == 0; }];
    NSArray *test = @[@"primum",@"secundo",@"tertia",@"finem"];
    
    XCTAssertTrue([filter isEqualToArray:test]);
}


@end
