//
//  SFBinarySearchTree.m
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import "SFBinarySearchTree.h"

@interface SFBinarySearchTree ()

@property (nonatomic, copy) SFComparatorBlock comparatorBlock;
@property (nonatomic, weak) id<SFComparator> comparator;

@end

@implementation SFBinarySearchTree

+ (instancetype)treeWithComparatorBlock:(_Nullable SFComparatorBlock)comparatorBlock{
    SFBinarySearchTree *bst = [[self alloc] init];
    bst.comparatorBlock = comparatorBlock;
    return bst;
}
+ (instancetype)treeWithComparator:(_Nullable id<SFComparator>)comparator{
    SFBinarySearchTree *bst = [[self alloc] init];
    bst.comparator = comparator;
    return bst;
}

- (void)addNode:(SFBinaryTreeNode *)node{
    if (!node) return;
    if (!self.rootNode) {
        self.rootNode = node;
    } else {
        SFBinaryTreeNode *parentNode = self.rootNode;
        SFBinaryTreeNode *compareNode = self.rootNode;
        int compare = 0;
        while (compareNode) {
            compare = [self _compare:node.element e2:compareNode.element];
            parentNode = compareNode;
            if (compare>0) {
                compareNode = compareNode.rightNode;
            } else if (compare<0) {
                compareNode = compareNode.leftNode;
            } else {
                compareNode = node;
                node.parentNode = parentNode;
                return;
            }
        }
        if (compare>0) {
            parentNode.rightNode = node;
        } else if (compare<0) {
            parentNode.leftNode = node;
        }
        node.parentNode = parentNode;
    }
    self.size++;
    [self addAfterNode:node];
}
- (void)addAfterNode:(SFBinaryTreeNode *)node{
    
}
- (void)removeNode:(SFBinaryTreeNode *)node{
    if (!node) return;
    if ([self hasTwoChildren:node]) {
        SFBinaryTreeNode *successorNode = [self getSuccessorNodeWithNode:node];
        node.element = successorNode.element;
        node = successorNode;
    }
    SFBinaryTreeNode *replacement = node.leftNode != nil ?node.leftNode : node.rightNode;
    if (replacement != nil) {// node是度为1的节点
        if (node == node.parentNode.leftNode) {
            node.parentNode.leftNode = replacement;
        } else if (node == node.parentNode.rightNode) {//
            node.parentNode.rightNode = replacement;
        } else {
            self.rootNode = replacement;
        }
        [self removeAfterNode:replacement];
    } else if (!node.parentNode) { // node是叶子节点并且是根节点
        self.rootNode = nil;
        [self removeAfterNode:node];
    } else {// node是叶子节点，但不是根节点
        if (node == node.parentNode.leftNode) {
            node.parentNode.leftNode = nil;
        } else if (node == node.parentNode.rightNode) {//
            node.parentNode.rightNode = nil;
        }
        [self removeAfterNode:node];
    }
    self.size--;
}
- (void)removeAfterNode:(SFBinaryTreeNode *)node{
    
}
- (SFBinaryTreeNode *)maxNode{
    SFBinaryTreeNode *parentNode = self.rootNode;
    SFBinaryTreeNode *node = self.rootNode;
    while (node) {
        parentNode = node;
        node = node.rightNode;
    }
    return parentNode;
}
- (SFBinaryTreeNode *)minNode{
    SFBinaryTreeNode *parentNode = self.rootNode;
    SFBinaryTreeNode *node = self.rootNode;
    while (node) {
        parentNode = node;
        node = node.leftNode;
    }
    return parentNode;
}
- (SFBinaryTreeNode *)getNodeWithObject:(id)anObject{
    if (!anObject) return nil;
    SFBinaryTreeNode *node = self.rootNode;
    while (node) {
        int imp = [self _compare:node.element e2:anObject];
        if (imp>0) {
            node = node.leftNode;
        } else if (imp<0){
            node = node.rightNode;
        } else {
            return node;
        }
    }
    return node;
}
#pragma mark - private methods
- (int)_compare:(id)e1 e2:(id)e2 {
    return self.comparatorBlock ? self.comparatorBlock(e1, e2) :
    (_comparator ? [_comparator compare:e1 another:e2] : (int)[e1 compare:e2]);
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
