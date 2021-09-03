//
//  SFBSTComparator.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SFBSTComparator <NSObject>

@required
- (int)compare:(id)e1 another:(id)e2;

@end

NS_ASSUME_NONNULL_END
