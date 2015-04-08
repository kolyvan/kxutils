//
//  SerializationTest.m
//  kxutils
//
//  Created by Kolyvan on 16.03.15.
//  Copyright (c) 2015 Kolyvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "KxSerialization.h"
#import "KxMacros.h"

@interface DummyObj : NSObject<KxSeriazable, NSCoding>
@property (readonly, nonatomic) NSUInteger readonlyValue;
@property (readwrite, nonatomic) BOOL boolValue;
@property (readwrite, nonatomic) NSUInteger intValue;
@property (readwrite, nonatomic) CGFloat floatValue;
@property (readwrite, nonatomic, strong) id idValue;
@property (readwrite, nonatomic, strong) NSNumber *numValue;
@property (readwrite, nonatomic, strong) NSString *strValue;
@property (readwrite, nonatomic, strong) NSDate *dateValue;
@property (readwrite, nonatomic, strong) NSArray *arrValue;
@property (readwrite, nonatomic, strong) NSDictionary *dictValue;
@property (readwrite, nonatomic, strong) DummyObj *childValue;
@property (readwrite, nonatomic, strong) void(^fakeBlock)();
@property (readwrite, nonatomic, strong) id tmpValue;
@end

@implementation DummyObj

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        [KxSerialization loadObject:self withCoder:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [KxSerialization saveObject:self withCoder:coder];
}

- (BOOL) isEqual:(id)other
{
    if (self == other) {
        return YES;
    }
    
    if (!other) {
        return NO;
    }
    
    if (![other isKindOfClass:[DummyObj class]]) {
        return NO;
    }
    
    return [self isEqualToDummyObj:other];
    
}

- (BOOL) isEqualToDummyObj:(DummyObj *)other
{
    return
    _readonlyValue == other->_readonlyValue &&
    _boolValue == other->_boolValue &&
    _intValue == other->_intValue &&
    _floatValue == other->_floatValue &&
    NSOBJ_ISEQUAL(_numValue, other->_numValue) &&
    NSOBJ_ISEQUAL(_strValue, other->_strValue) &&
    NSOBJ_ISEQUAL(_dateValue, other->_dateValue) &&
    NSOBJ_ISEQUAL(_arrValue, other->_arrValue) &&
    NSOBJ_ISEQUAL(_dictValue, other->_dictValue) &&
    NSOBJ_ISEQUAL(_childValue, other->_childValue) &&
    NSOBJ_ISEQUAL(_idValue, other->_idValue);
}

+ (id<KxSerializationTransformer>) serializationTransformer
{
    return [KxSerializationTransformerDate sharedTransformer];
}

+ (NSSet *) serializationBlacklistProperties
{
    return [NSSet setWithObjects:@"tmpValue", nil];
}

@end

////////////

@interface SerializationTest : XCTestCase

@end

@implementation SerializationTest {
    
    DummyObj *_obj;
}

- (void)setUp {
    [super setUp];
    
    _obj = [DummyObj new];
    _obj.boolValue = YES;
    _obj.intValue = 42;
    _obj.floatValue = 3.14;
    _obj.dateValue = [NSDate date];
    _obj.numValue = @12345678;
    _obj.strValue = @"Alice";
    _obj.arrValue = @[@1, @3, @5, @7];
    _obj.childValue = [DummyObj new];
    _obj.childValue.strValue = @"Bob";
    _obj.childValue.dictValue = @{ @"color" : @"red" };
    _obj.tmpValue = @777;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDictionary {

    NSDictionary *dict = [KxSerialization saveObjectAsDictionary:_obj];
    
    XCTAssertNotNil(dict);
    XCTAssertTrue(dict.count == 8);
    
    DummyObj *testObj = [DummyObj new];
    [KxSerialization loadObject:testObj withDictionary:dict];

    XCTAssertEqualObjects(_obj, testObj);
    XCTAssertNil(testObj.tmpValue);
}

- (void)testCoder {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_obj];
    
    XCTAssertNotNil(data);
    XCTAssertTrue(data.length > 0);
    
    DummyObj *testObj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    XCTAssertEqualObjects(_obj, testObj);
    XCTAssertNil(testObj.tmpValue);
}

@end
