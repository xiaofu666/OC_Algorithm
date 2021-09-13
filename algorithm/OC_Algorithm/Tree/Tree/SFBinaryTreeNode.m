//
//  SFBinaryTreeNode.m
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import "SFBinaryTreeNode.h"

@implementation SFBinaryTreeNode

- (void)dealloc{
    NSLog(@"%s",__func__);
}

+ (instancetype)nodeWithElement:(id _Nonnull)element{
    SFBinaryTreeNode *node = [[self alloc] init];
    node.element = element;
    node.height = 1;
    node.color = NO;
    return node;
}
- (void)updateHeight{
    NSInteger leftHeight  = self.leftNode  ? self.leftNode.height  : 0;
    NSInteger rightHeight = self.rightNode ? self.rightNode.height : 0;
    self.height = MAX(leftHeight, rightHeight)+1;
}
- (BOOL)isLeft:(SFBinaryTreeNode *)node{
    return self == node.leftNode;
}
- (BOOL)isRight:(SFBinaryTreeNode *)node{
    return self == node.rightNode;
}
- (BOOL)isLeftChild{
    return self==self.parentNode.leftNode;
}
- (BOOL)isRightChild{
    return self==self.parentNode.rightNode;
}
//兄弟节点
- (SFBinaryTreeNode *)siblingNode{
    if ([self isLeftChild]) {
        return self.parentNode.rightNode;
    }
    if ([self isRightChild]) {
        return self.parentNode.leftNode;
    }
    return nil;
}

@end
