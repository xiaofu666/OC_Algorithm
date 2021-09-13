//
//  SFBinaryTreeNode.h
//  ApiTestDemo
//
//  Created by lurich on 2021/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFBinaryTreeNode : NSObject

@property (nonatomic) id _Nonnull element;
@property (nonatomic, strong) SFBinaryTreeNode * _Nullable leftNode;
@property (nonatomic, strong) SFBinaryTreeNode * _Nullable rightNode;
@property (nonatomic, strong) SFBinaryTreeNode * _Nullable parentNode;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign, getter=isColor) BOOL color;

+ (instancetype)nodeWithElement:(id _Nonnull)element;
- (void)updateHeight;//深度
- (BOOL)isLeft:(SFBinaryTreeNode *)node;
- (BOOL)isRight:(SFBinaryTreeNode *)node;
- (BOOL)isLeftChild;
- (BOOL)isRightChild;
//兄弟节点
- (SFBinaryTreeNode *)siblingNode;

@end

NS_ASSUME_NONNULL_END
