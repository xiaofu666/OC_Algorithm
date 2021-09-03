//
//  SFTwowayCircleLinkedList.h
//  ApiTestDemo
//
//  Created by lurich on 2021/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFTwowayCircleLinkedList : NSObject

- (void)clear;
- (NSInteger)size;
- (BOOL)isEmpty;
- (void)addObject:(id)anObject;
- (id)getObjectAtIndex:(NSInteger)index;
- (void)setObject:(id)anObject AtIndex:(NSInteger)index;
- (id)removeObjectAtIndex:(NSUInteger)index;
- (NSInteger)indexOfObject:(id)anObject;
- (id)current;
- (id)next;
- (id)prev;

@end

NS_ASSUME_NONNULL_END
