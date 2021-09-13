//
//  SFBinaryTree.m
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import "SFBinaryTree.h"

@interface SFBinaryTree ()

@end

@implementation SFBinaryTree

+ (instancetype)tree{
    SFBinaryTree *binaryTree = [[self alloc] init];
    return binaryTree;
}
- (NSInteger)size{
    return _size;
}
- (BOOL)isEmpty{
    return self.size==0;
}
- (void)clear{
    SFQueue *queue = [SFQueue new];
    [queue enQueueObject:self.rootNode];
    while (queue.size) {
        SFBinaryTreeNode *node = [queue deQueue];
        node.parentNode = nil;
        if (node.leftNode) {
            [queue enQueueObject:node.leftNode];
        }
        if (node.rightNode) {
            [queue enQueueObject:node.rightNode];
        }
    }
    self.rootNode = nil;
    self.size = 0;
}
- (BOOL)hasTwoChildren:(SFBinaryTreeNode *)node{
    return node.leftNode && node.rightNode;
}
//前驱节点
- (SFBinaryTreeNode *)getPrecursorNodeWithNode:(SFBinaryTreeNode *)node{
    if (!node.leftNode) return nil;
    SFBinaryTreeNode *parenNode = node;
    node = node.leftNode;
    while (node) {
        parenNode = node;
        node = parenNode.rightNode;
    }
    return parenNode;
}
//后继节点
- (SFBinaryTreeNode *)getSuccessorNodeWithNode:(SFBinaryTreeNode *)node{
    if (!node.rightNode) return nil;
    SFBinaryTreeNode *parenNode = node;
    node = node.rightNode;
    while (node) {
        parenNode = node;
        node = node.leftNode;
    }
    return parenNode;
}
//前序遍历
- (void)preorderWithNode:(SFBinaryTreeNode *)node{
    if (!node) return;
    [self.elementArray addObject:node.element];
    if (node.leftNode) {
        [self preorderWithNode:node.leftNode];
    }
    if (node.rightNode) {
        [self preorderWithNode:node.rightNode];
    }
}
//中序遍历
- (void)inorderWithNode:(SFBinaryTreeNode *)node{
    if (!node) return;
    if (node.leftNode) {
        [self inorderWithNode:node.leftNode];
    }
    [self.elementArray addObject:node.element];
    if (node.rightNode) {
        [self inorderWithNode:node.rightNode];
    }
}
//后序遍历
- (void)postorderWithNode:(SFBinaryTreeNode *)node{
    if (!node) return;
    if (node.leftNode) {
        [self postorderWithNode:node.leftNode];
    }
    if (node.rightNode) {
        [self postorderWithNode:node.rightNode];
    }
    [self.elementArray addObject:node.element];
}
//层序遍历
- (void)levelWithNode:(SFBinaryTreeNode *)node{
    if (!node) return;
    SFQueue *queue = [SFQueue new];
    [queue enQueueObject:node];
    while (queue.size) {
        SFBinaryTreeNode *getNode = [queue deQueue];
        [self.elementArray addObject:getNode.element];
        if (getNode.leftNode) {
            [queue enQueueObject:getNode.leftNode];
        }
        if (getNode.rightNode) {
            [queue enQueueObject:getNode.rightNode];
        }
    }
}
- (NSMutableArray *)elementArray{
    if (!_elementArray) {
        _elementArray = [NSMutableArray array];
    }
    return _elementArray;
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
