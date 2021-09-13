//
//  SFAVLTree.m
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import "SFAVLTree.h"

@implementation SFAVLTree

- (void)addAfterNode:(SFBinaryTreeNode *)node{
    while ((node = node.parentNode) != nil) {
        if ([self isBalancedWithNode:node]) {
            [node updateHeight];
        } else {
            //两种算法
            [self rebalanceNode2:node];
//            [self rebalanceNode1:node];
            break;
        }
    }
}
- (void)removeAfterNode:(SFBinaryTreeNode *)node{
    while ((node = node.parentNode) != nil) {
        if ([self isBalancedWithNode:node]) {
            [node updateHeight];
        } else {
            //两种算法
            [self rebalanceNode2:node];
//            [self rebalanceNode1:node];
        }
    }
}
- (SFBinaryTreeNode *)childNodeWithNode:(SFBinaryTreeNode *)node{
    NSInteger leftHeight = node.leftNode.height;
    NSInteger rightHeight = node.rightNode.height;
    if (leftHeight>rightHeight) {
        return node.leftNode;
    } else if (leftHeight<rightHeight) {
        return node.rightNode;
    } else {
        return [node isLeftChild]?node.leftNode:node.rightNode;
    }
}
- (BOOL)isBalancedWithNode:(SFBinaryTreeNode *)node{
    NSInteger leftHeight = node.leftNode.height;
    NSInteger rightHeight = node.rightNode.height;
    NSInteger ceilHeight = labs(leftHeight-rightHeight);
    return ceilHeight<=1?YES:NO;
}

//恢复平衡  算法2
- (void)rebalanceNode2:(SFBinaryTreeNode *)gNode{
    //找到失去平衡节点的子节点
    SFBinaryTreeNode *pNode = [self childNodeWithNode:gNode];
    SFBinaryTreeNode *childNode = [self childNodeWithNode:pNode];
    if ([pNode isLeft:gNode]) { //L
        if ([childNode isLeft:pNode]) {//LL
            NSLog(@"LL");
            [self rotateNodeWithRightNode:gNode];
        } else {//LR
            NSLog(@"LR");
            [self rotateNodeWithLeftNode:pNode];
            [self rotateNodeWithRightNode:gNode];
        }
    } else {//R
        if ([childNode isRight:pNode]) {//RR
            NSLog(@"RR");
            [self rotateNodeWithLeftNode:gNode];
        } else {//RL
            NSLog(@"RL");
            [self rotateNodeWithRightNode:pNode];
            [self rotateNodeWithLeftNode:gNode];
        }
    }
}
- (void)assembleNewTreeWithRootNode:(SFBinaryTreeNode *)R ANode:(SFBinaryTreeNode *)A BNode:(SFBinaryTreeNode *)B CNode:(SFBinaryTreeNode *)C DNode:(SFBinaryTreeNode *)D ENode:(SFBinaryTreeNode *)E FNode:(SFBinaryTreeNode *)F GNode:(SFBinaryTreeNode *)G{
    D.parentNode = R.parentNode;
    if (R.isLeftChild) {
        R.parentNode.leftNode = D;
    } else if (R.isRightChild) {
        R.parentNode.rightNode = D;
    } else {
        self.rootNode = D;
    }
    
    //A-B-C
    [self assembleNewTreeWithLeftNode:A CurrentNode:B RightNode:C];
    
    //E-F-G
    [self assembleNewTreeWithLeftNode:E CurrentNode:F RightNode:G];
    
    //B-D-F
    [self assembleNewTreeWithLeftNode:B CurrentNode:D RightNode:F];
}
- (void)assembleNewTreeWithLeftNode:(SFBinaryTreeNode *)leftNode CurrentNode:(SFBinaryTreeNode *)currentNode RightNode:(SFBinaryTreeNode *)rightNode{
    currentNode.leftNode = leftNode;
    if (leftNode) {
        leftNode.parentNode = currentNode;
    }
    currentNode.rightNode = rightNode;
    if (rightNode) {
        rightNode.parentNode = rightNode;
    }
    [currentNode updateHeight];
}

//恢复平衡  算法1
- (void)rebalanceNode1:(SFBinaryTreeNode *)gNode{
    //找到失去平衡节点的子节点
    SFBinaryTreeNode *pNode = [self childNodeWithNode:gNode];
    SFBinaryTreeNode *childNode = [self childNodeWithNode:pNode];
    if ([pNode isLeft:gNode]) { //L
        if ([childNode isLeft:pNode]) {//LL
            NSLog(@"LL");
            [self rotateNodeWithRightNode:gNode];
        } else {//LR
            NSLog(@"LR");
            [self rotateNodeWithLeftNode:pNode];
            [self rotateNodeWithRightNode:gNode];
        }
    } else {//R
        if ([childNode isRight:pNode]) {//RR
            NSLog(@"RR");
            [self rotateNodeWithLeftNode:gNode];
        } else {//RL
            NSLog(@"RL");
            [self rotateNodeWithRightNode:pNode];
            [self rotateNodeWithLeftNode:gNode];
        }
    }
}
//向左旋转Node
- (void)rotateNodeWithLeftNode:(SFBinaryTreeNode *)gNode{
    SFBinaryTreeNode *pNode = gNode.rightNode;
    SFBinaryTreeNode *childNode = pNode.leftNode;
    pNode.leftNode = gNode;
    gNode.rightNode = childNode;
    
    [self afterRotateWithGrandNode:gNode ParentNode:pNode ChildNode:childNode];
}
//向右旋转Node
- (void)rotateNodeWithRightNode:(SFBinaryTreeNode *)gNode{
    SFBinaryTreeNode *pNode = gNode.leftNode;
    SFBinaryTreeNode *childNode = pNode.rightNode;
    pNode.rightNode = gNode;
    gNode.leftNode = childNode;
    
    [self afterRotateWithGrandNode:gNode ParentNode:pNode ChildNode:childNode];
}
- (void)afterRotateWithGrandNode:(SFBinaryTreeNode *)grand ParentNode:(SFBinaryTreeNode *)parent ChildNode:(SFBinaryTreeNode *)child{
    // 让parent称为子树的根节点
    parent.parentNode = grand.parentNode;
    if (grand.isLeftChild) {
        grand.parentNode.leftNode = parent;
    } else if (grand.isRightChild) {
        grand.parentNode.rightNode = parent;
    } else { // grand是root节点
        self.rootNode = parent;
    }

    // 更新child的parent
    if (child != nil) {
        child.parentNode = grand;
    }

    // 更新grand的parent
    grand.parentNode = parent;
    
    [grand updateHeight];
    [parent updateHeight];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
