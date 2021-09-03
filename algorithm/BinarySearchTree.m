//
//  BinarySearchTree.m
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import "BinarySearchTree.h"

@interface BinarySearchTree ()

@property (nonatomic, strong) SFAVLTree *searchTree;

@end

@implementation BinarySearchTree

+ (instancetype)tree{
    return [self treeWithComparator:nil];
}
+ (instancetype)treeWithComparatorBlock:(_Nullable SFBSTComparatorBlock)comparatorBlock{
    BinarySearchTree *tree = [[self alloc] init];
    tree.searchTree = [SFAVLTree treeWithComparatorBlock:comparatorBlock];
    return tree;
}
+ (instancetype)treeWithComparator:(_Nullable id<SFBSTComparator>)comparator{
    BinarySearchTree *tree = [[self alloc] init];
    tree.searchTree = [SFAVLTree treeWithComparator:comparator];
    return tree;
}

- (BOOL)isEmpty{
    return [self.searchTree isEmpty];
}
- (void)clear{
    [self.searchTree clear];
}
- (void)addObject:(id)anObject{
    if (!anObject) return;
    SFBinaryTreeNode *node = [SFBinaryTreeNode nodeWithElement:anObject];
    [self.searchTree addNode:node];
}
- (void)removeObject:(id)anObject{
    if (!anObject) return;
    SFBinaryTreeNode *node = [self.searchTree getNodeWithObject:anObject];
    [self.searchTree removeNode:node];
}
- (BOOL)containsObject:(id)anObject{
    if (!anObject) return NO;
    return YES;
}
- (NSInteger)heightWithObject:(id)anObject{
    if (!anObject) return -1;
    SFBinaryTreeNode *node = [self.searchTree getNodeWithObject:anObject];
    [node updateHeight];
    return node.height;
}
- (void)leftAndRightHeightWithObject:(id)anObject{
    if (!anObject) return ;
    SFBinaryTreeNode *node = [self.searchTree getNodeWithObject:anObject];
    [node.leftNode updateHeight];
    [node.rightNode updateHeight];
    NSLog(@"node.leftNode:%zd  =  node.rightNode:%zd",node.leftNode.height,node.rightNode.height);
}

- (id)rootObject{
    return self.searchTree.rootNode.element;
}
- (id)maxObject{
    return self.searchTree.maxNode.element;
}
- (id)minObject{
    return self.searchTree.minNode.element;
}
//前驱值
- (id)getPrecursorWithObject:(id)anObject{
    SFBinaryTreeNode *node = [self.searchTree getNodeWithObject:anObject];
    return [self.searchTree getPrecursorNodeWithNode:node].element;
}
//后继值
- (id)getSuccessorWithObject:(id)anObject{
    SFBinaryTreeNode *node = [self.searchTree getNodeWithObject:anObject];
    return [self.searchTree getSuccessorNodeWithNode:node].element;
}

//传入某个节点值，返回该节点下所有元素，传nil默认为root节点
//前序遍历
- (NSArray *)preorderTraversalWithObject:(id)anObject{
    SFBinaryTreeNode *node = anObject?[self.searchTree getNodeWithObject:anObject]:self.searchTree.rootNode;
    [self.searchTree.elementArray removeAllObjects];
    [self.searchTree preorderWithNode:node];
    return [NSArray arrayWithArray:self.searchTree.elementArray];
}
//中序遍历
- (NSArray *)inorderTraversalWithObject:(id)anObject{
    SFBinaryTreeNode *node = anObject?[self.searchTree getNodeWithObject:anObject]:self.searchTree.rootNode;
    [self.searchTree.elementArray removeAllObjects];
    [self.searchTree inorderWithNode:node];
    return [NSArray arrayWithArray:self.searchTree.elementArray];
}
//后序遍历
- (NSArray *)postorderTraversalWithObject:(id)anObject{
    SFBinaryTreeNode *node = anObject?[self.searchTree getNodeWithObject:anObject]:self.searchTree.rootNode;
    [self.searchTree.elementArray removeAllObjects];
    [self.searchTree postorderWithNode:node];
    return [NSArray arrayWithArray:self.searchTree.elementArray];
}
//层序遍历
- (NSArray *)levelOrderTraversalWithObject:(id)anObject{
    SFBinaryTreeNode *node = anObject?[self.searchTree getNodeWithObject:anObject]:self.searchTree.rootNode;
    [self.searchTree.elementArray removeAllObjects];
    [self.searchTree levelWithNode:node];
    return [NSArray arrayWithArray:self.searchTree.elementArray];
}
#pragma mark - 打印
/**
 * who is the root node
 */
- (id)root{
    return self.searchTree.rootNode;
}
/**
 * how to get the left child of the node
 */
- (id)left:(SFBinaryTreeNode *)node{
    return node.leftNode;
}
/**
 * how to get the right child of the node
 */
- (id)right:(SFBinaryTreeNode *)node{
    return node.rightNode;
}
/**
 * how to print the node
 */
- (id)string:(SFBinaryTreeNode *)node{
    return node.element;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
