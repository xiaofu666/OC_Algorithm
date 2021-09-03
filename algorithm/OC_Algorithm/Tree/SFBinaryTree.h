//
//  SFBinaryTree.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import <Foundation/Foundation.h>
#import "SFBinaryTreeNode.h"
#import "SFQueue.h"

@interface SFBinaryTree : NSObject

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) SFBinaryTreeNode * _Nullable rootNode;
@property (nonatomic, strong) NSMutableArray * _Nullable elementArray;

- (BOOL)isEmpty;
- (void)clear;
- (BOOL)hasTwoChildren:(SFBinaryTreeNode *_Nonnull)node;
//前驱节点
- (SFBinaryTreeNode *_Nullable)getPrecursorNodeWithNode:(SFBinaryTreeNode *_Nonnull)node;
//后继节点
- (SFBinaryTreeNode *_Nullable)getSuccessorNodeWithNode:(SFBinaryTreeNode *_Nonnull)node;
//前序遍历
- (void)preorderWithNode:(SFBinaryTreeNode *_Nonnull)node;
//中序遍历
- (void)inorderWithNode:(SFBinaryTreeNode *_Nonnull)node;
//后序遍历
- (void)postorderWithNode:(SFBinaryTreeNode *_Nonnull)node;
//层序遍历
- (void)levelWithNode:(SFBinaryTreeNode *_Nonnull)node;

@end
