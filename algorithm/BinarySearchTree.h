//
//  BinarySearchTree.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import <Foundation/Foundation.h>
#import "SFAVLTree.h"
#import "MJBinaryTreeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinarySearchTree : NSObject <MJBinaryTreeInfo>

+ (instancetype)tree;
+ (instancetype)treeWithComparatorBlock:(_Nullable SFBSTComparatorBlock)comparatorBlock;
+ (instancetype)treeWithComparator:(_Nullable id<SFBSTComparator>)comparator;

- (BOOL)isEmpty;
- (void)clear;
- (void)addObject:(id)anObject;
- (void)removeObject:(id)anObject;
- (BOOL)containsObject:(id)anObject;
//-1:没有该节点 0:叶子结点
- (NSInteger)heightWithObject:(id)anObject;

- (void)leftAndRightHeightWithObject:(id)anObject;

- (id)rootObject;
- (id)maxObject;
- (id)minObject;
//前驱值
- (id)getPrecursorWithObject:(id)anObject;
//后继值
- (id)getSuccessorWithObject:(id)anObject;

//传入某个节点值，返回该节点下所有元素，传nil默认为root节点
//前序遍历
- (NSArray *)preorderTraversalWithObject:(id _Nullable)anObject;
//中序遍历
- (NSArray *)inorderTraversalWithObject:(id _Nullable)anObject;
//后序遍历
- (NSArray *)postorderTraversalWithObject:(id _Nullable)anObject;
//层序遍历
- (NSArray *)levelOrderTraversalWithObject:(id _Nullable)anObject;

@end

NS_ASSUME_NONNULL_END
