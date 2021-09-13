//
//  SFRedBlackTree.m
//  algorithm
//
//  Created by lurich on 2021/9/13.
//

#import "SFRedBlackTree.h"

@interface SFRedBlackTree ()
// RED : NO;    BLACK : YES
@end

@implementation SFRedBlackTree

- (SFBinaryTreeNode *)colorWithNode:(SFBinaryTreeNode *)node Color:(BOOL)color{
    if (node == nil) return node;
    node.color = color;
    return node;
}

- (SFBinaryTreeNode *)redColorNode:(SFBinaryTreeNode *)node{
    return [self colorWithNode:node Color:NO];
}

- (SFBinaryTreeNode *)blackColorNode:(SFBinaryTreeNode *)node{
    return [self colorWithNode:node Color:YES];
}

- (BOOL)colorOfNode:(SFBinaryTreeNode *)node{
    return node == nil ? YES : node.color;
}

- (BOOL)isBlackNode:(SFBinaryTreeNode *)node{
    return [self colorOfNode:node] == YES;
}

- (BOOL)isRedNode:(SFBinaryTreeNode *)node{
    return [self colorOfNode:node] == NO;
}

- (void)addAfterNode:(SFBinaryTreeNode *)node{
    SFBinaryTreeNode *parentNode = node.parentNode;
    // 添加的是根节点 或者 上溢到达了根节点
    if (parentNode == nil) {
        [self blackColorNode:node];
        return;
    }
    // 如果父节点是黑色，直接返回
    if ([self isBlackNode:parentNode]) return;
    
    // 叔父节点
    SFBinaryTreeNode *uncleNode = [parentNode siblingNode];
    // 祖父节点
    SFBinaryTreeNode *grandNode = [self redColorNode:parentNode.parentNode];
    if (grandNode==nil) {
        return;
    }
    if ([self isRedNode:uncleNode]) {// 叔父节点是红色【B树节点上溢】
        [self blackColorNode:parentNode];
        [self blackColorNode:uncleNode];
        // 把祖父节点当做是新添加的节点
        [self addAfterNode:grandNode];
        return;
    }
    // 叔父节点不是红色
    if ([parentNode isLeftChild]) {//L
        if ([node isLeftChild]) {//LL
            [self blackColorNode:parentNode];
        } else {//LR
            [self blackColorNode:node];
            [self rotateNodeWithLeftNode:parentNode];
        }
        [self rotateNodeWithRightNode:grandNode];
    } else {// R
        if ([node isRightChild]) {//RR
            [self blackColorNode:parentNode];
        } else {//RL
            [self blackColorNode:node];
            [self rotateNodeWithRightNode:parentNode];
        }
        [self rotateNodeWithLeftNode:grandNode];
    }
    
}
- (void)removeAfterNode:(SFBinaryTreeNode *)node{
    // 如果删除的节点是红色
    // 或者 用以取代删除节点的子节点是红色
    if ([self isRedNode:node]) {
        [self blackColorNode:node];
        return;
    }
    SFBinaryTreeNode *parentNode = node.parentNode;
    // 删除的是根节点
    if (parentNode == nil) return;
    // 删除的是黑色叶子节点【下溢】
    // 判断被删除的node是左还是右
    BOOL  isLeft = parentNode.leftNode==nil || [node isLeftChild];
    SFBinaryTreeNode *siblingNode = isLeft ? parentNode.rightNode : parentNode.leftNode;
    if (isLeft) {// 被删除的节点在左边，兄弟节点在右边
        if ([self isRedNode:siblingNode]) {// 兄弟节点是红色
            [self blackColorNode:siblingNode];
            [self redColorNode:parentNode];
            [self rotateNodeWithLeftNode:parentNode];
            // 更换兄弟
            siblingNode = parentNode.rightNode;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlackNode:siblingNode.leftNode] && [self isBlackNode:siblingNode.rightNode]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlackNode:parentNode];
            [self blackColorNode:parentNode];
            [self redColorNode:siblingNode];
            if (parentBlack) {
                [self removeAfterNode:parentNode];
            }
        } else {// 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlackNode:siblingNode.rightNode]) {
                [self rotateNodeWithRightNode:siblingNode];
                siblingNode = parentNode.rightNode;
            }
            [self colorWithNode:siblingNode Color:[self colorOfNode:parentNode]];
            [self blackColorNode:siblingNode.rightNode];
            [self blackColorNode:parentNode];
            [self rotateNodeWithLeftNode:parentNode];
        }
        
    } else {// 被删除的节点在右边，兄弟节点在左边
        if ([self isRedNode:siblingNode]) {// 兄弟节点是红色
            [self blackColorNode:siblingNode];
            [self redColorNode:parentNode];
            [self rotateNodeWithRightNode:parentNode];
            // 更换兄弟
            siblingNode = parentNode.leftNode;
        }
        
        // 兄弟节点必然是黑色
        if ([self isBlackNode:siblingNode.leftNode] && [self isBlackNode:siblingNode.rightNode]) {
            // 兄弟节点没有1个红色子节点，父节点要向下跟兄弟节点合并
            BOOL parentBlack = [self isBlackNode:parentNode];
            [self blackColorNode:parentNode];
            [self redColorNode:siblingNode];
            if (parentBlack) {
                [self removeAfterNode:parentNode];
            }
        } else {// 兄弟节点至少有1个红色子节点，向兄弟节点借元素
            // 兄弟节点的左边是黑色，兄弟要先旋转
            if ([self isBlackNode:siblingNode.leftNode]) {
                [self rotateNodeWithLeftNode:siblingNode];
                siblingNode = parentNode.leftNode;
            }
            [self colorWithNode:siblingNode Color:[self colorOfNode:parentNode]];
            [self blackColorNode:siblingNode.leftNode];
            [self blackColorNode:parentNode];
            [self rotateNodeWithRightNode:parentNode];
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
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
