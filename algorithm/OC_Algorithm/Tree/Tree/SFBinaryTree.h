//
//  SFBinaryTree.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import <Foundation/Foundation.h>
#import "SFBinaryTreeNode.h"
#import "SFQueue.h"


NS_ASSUME_NONNULL_BEGIN

@interface SFBinaryTree : NSObject

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) SFBinaryTreeNode * _Nullable rootNode;
@property (nonatomic, strong) NSMutableArray * _Nullable elementArray;

+ (instancetype)tree;

- (BOOL)isEmpty;
- (void)clear;
- (BOOL)hasTwoChildren:(SFBinaryTreeNode *)node;
//前驱节点
- (SFBinaryTreeNode *_Nullable)getPrecursorNodeWithNode:(SFBinaryTreeNode *)node;
//后继节点
- (SFBinaryTreeNode *_Nullable)getSuccessorNodeWithNode:(SFBinaryTreeNode *)node;
//前序遍历
- (void)preorderWithNode:(SFBinaryTreeNode *)node;
//中序遍历
- (void)inorderWithNode:(SFBinaryTreeNode *)node;
//后序遍历
- (void)postorderWithNode:(SFBinaryTreeNode *)node;
//层序遍历
- (void)levelWithNode:(SFBinaryTreeNode *)node;

@end

NS_ASSUME_NONNULL_END
