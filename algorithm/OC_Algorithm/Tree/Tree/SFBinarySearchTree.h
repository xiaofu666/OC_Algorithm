//
//  SFBinarySearchTree.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import "SFBinaryTree.h"
#import "SFComparator.h"

@interface SFBinarySearchTree : SFBinaryTree

+ (instancetype _Nonnull )treeWithComparatorBlock:(_Nullable SFComparatorBlock)comparatorBlock;
+ (instancetype _Nonnull )treeWithComparator:(_Nullable id<SFComparator>)comparator;

- (void)addNode:(SFBinaryTreeNode *_Nonnull)node;
- (void)removeNode:(SFBinaryTreeNode *_Nonnull)node;
- (SFBinaryTreeNode *_Nullable)getNodeWithObject:(id _Nonnull )anObject;

- (SFBinaryTreeNode *_Nullable)maxNode;
- (SFBinaryTreeNode *_Nullable)minNode;

@end
