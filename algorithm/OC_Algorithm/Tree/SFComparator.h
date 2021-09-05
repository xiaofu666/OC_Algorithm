//
//  SFComparator.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import <Foundation/Foundation.h>

typedef int (^SFComparatorBlock)(id _Nonnull e1, id _Nonnull e2);

NS_ASSUME_NONNULL_BEGIN

@protocol SFComparator <NSObject>

@required
- (int)compare:(id)e1 another:(id)e2;

@end

NS_ASSUME_NONNULL_END
