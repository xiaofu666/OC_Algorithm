//
//  SFTwowayLinkedList.m
//  ApiTestDemo
//
//  Created by lurich on 2021/8/30.
//

#import "SFTwowayLinkedList.h"

@interface SFTwowayLinkedNode : NSObject

@property (nonatomic) id _Nonnull element;
@property (nonatomic, strong) SFTwowayLinkedNode * _Nullable nextNode;
@property (nonatomic, strong) SFTwowayLinkedNode * _Nullable prevNode;

@end

@implementation SFTwowayLinkedNode

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

@interface SFTwowayLinkedList ()

@property (nonatomic, strong) SFTwowayLinkedNode *firstNode;
@property (nonatomic, strong) SFTwowayLinkedNode *lastNode;
@property (nonatomic, assign) NSInteger size;

@end

@implementation SFTwowayLinkedList

- (void)clear{
    while (self.size) {
        self.lastNode = self.lastNode.prevNode;
        self.lastNode.nextNode = nil;
        self.size --;
    }
    self.firstNode = nil;
}
- (NSInteger)size{
    return _size;
}
- (BOOL)isEmpty{
    return self.size==0;
}
- (void)addObject:(id)anObject{
    [self setObject:anObject AtIndex:self.size];
}
- (SFTwowayLinkedNode *)getNodeWithIndex:(NSInteger)index{
    if (index>=self.size || index<0) NSAssert(NO, @"数组越界");
    SFTwowayLinkedNode *node = self.firstNode;
    while (index>0) {
        node = node.nextNode;
        index--;
    }
    return node;
}
- (id)getObjectAtIndex:(NSInteger)index{
    SFTwowayLinkedNode *node = [self getNodeWithIndex:index];
    return node.element;
}
- (void)setObject:(id)anObject AtIndex:(NSInteger)index{
    SFTwowayLinkedNode *newNode = [SFTwowayLinkedNode new];
    newNode.element = anObject;
    if (index==0) {
        newNode.prevNode = nil;
        if (!_firstNode) {
            newNode.nextNode = nil;
            self.firstNode = newNode;
            self.lastNode = newNode;
        } else {
            newNode.nextNode = self.firstNode;
            self.firstNode = newNode;
        }
    }
    else if (index == self.size) {
        SFTwowayLinkedNode *oldNode = [self getNodeWithIndex:index-1];
        oldNode.nextNode = newNode;
        newNode.prevNode = oldNode;
        newNode.nextNode = nil;
        self.lastNode = newNode;
    }
    else {
        SFTwowayLinkedNode *oldNode = [self getNodeWithIndex:index-1];
        oldNode.nextNode.prevNode = newNode;
        newNode.nextNode = oldNode.nextNode;
        oldNode.nextNode = newNode;
        newNode.prevNode = oldNode;
    }
    self.size ++;
}
- (id)removeObjectAtIndex:(NSUInteger)index{
    SFTwowayLinkedNode *node = [self getNodeWithIndex:index];
    if (node.prevNode) {
        if (node.nextNode) {
            node.prevNode.nextNode = node.nextNode;
            node.nextNode.prevNode = node.prevNode;
        } else {
            node.prevNode.nextNode = nil;
            self.lastNode = node.prevNode;
        }
        
    } else {
        node.nextNode.prevNode = nil;
        self.firstNode = node.nextNode;
    }
    self.size--;
    id obj = node.element;
    node = nil;
    return obj;
}
- (NSInteger)indexOfObject:(id)anObject{
    NSInteger runNum = self.size;
    SFTwowayLinkedNode *node = self.firstNode;
    while (runNum>0) {
        if ([node.element isEqual:anObject]) {
            break;
        }
        node = node.nextNode;
        runNum--;
    }
    return self.size-runNum;
}
- (NSString *)description{
    SFTwowayLinkedNode *node = self.firstNode;
    NSInteger index = self.size;
    NSString *print = @"\n";
    while (index!=0) {
        print = [NSString stringWithFormat:@"%@，%@",print,node.element];
        node = node.nextNode;
        index--;
    }
    return print;
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
