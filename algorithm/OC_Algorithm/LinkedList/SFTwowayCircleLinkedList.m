//
//  SFTwowayCircleLinkedList.m
//  ApiTestDemo
//
//  Created by lurich on 2021/8/30.
//

#import "SFTwowayCircleLinkedList.h"

@interface SFTwowayCircleLinkedNode : NSObject

@property (nonatomic) id _Nonnull element;
@property (nonatomic, strong) SFTwowayCircleLinkedNode * _Nullable nextNode;
@property (nonatomic, strong) SFTwowayCircleLinkedNode * _Nullable prevNode;

@end

@implementation SFTwowayCircleLinkedNode

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

@interface SFTwowayCircleLinkedList ()

@property (nonatomic, strong) SFTwowayCircleLinkedNode *firstNode;
@property (nonatomic, strong) SFTwowayCircleLinkedNode *lastNode;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger size;

@end

@implementation SFTwowayCircleLinkedList

- (void)clear{
    while (self.size) {
        self.lastNode = self.lastNode.prevNode;
        self.lastNode.nextNode = nil;
        self.size --;
    }
    self.firstNode.prevNode = nil;
    self.firstNode = nil;
    self.currentIndex = 0;
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
- (SFTwowayCircleLinkedNode *)getNodeWithIndex:(NSInteger)index{
    if (index>=self.size || index<0) NSAssert(NO, @"数组越界");
    SFTwowayCircleLinkedNode *node;
    if (index<=(self.size>>1)) {
        node = self.firstNode;
        while (index>0) {
            node = node.nextNode;
            index--;
        }
    } else {
        NSInteger runNum = self.size-1-index;
        node = self.lastNode;
        while (runNum>0) {
            node = node.prevNode;
            runNum--;
        }
    }
    return node;
}
- (id)getObjectAtIndex:(NSInteger)index{
    SFTwowayCircleLinkedNode *node = [self getNodeWithIndex:index];
    return node.element;
}
- (void)setObject:(id)anObject AtIndex:(NSInteger)index{
    SFTwowayCircleLinkedNode *newNode = [SFTwowayCircleLinkedNode new];
    newNode.element = anObject;
    if (index==0) {
        if (!_firstNode) {
            newNode.nextNode = nil;
            self.lastNode = newNode;
        } else {
            newNode.nextNode = self.firstNode;
        }
        newNode.prevNode = self.lastNode;
        self.firstNode = newNode;
    }
    else if (index == self.size) {
        SFTwowayCircleLinkedNode *oldNode = [self getNodeWithIndex:index-1];
        oldNode.nextNode = newNode;
        newNode.prevNode = oldNode;
        newNode.nextNode = self.firstNode;
        self.lastNode = newNode;
    }
    else {
        SFTwowayCircleLinkedNode *oldNode = [self getNodeWithIndex:index-1];
        oldNode.nextNode.prevNode = newNode;
        newNode.nextNode = oldNode.nextNode;
        oldNode.nextNode = newNode;
        newNode.prevNode = oldNode;
    }
    self.size ++;
}
- (id)removeObjectAtIndex:(NSUInteger)index{
    SFTwowayCircleLinkedNode *node = [self getNodeWithIndex:index];
    node.prevNode.nextNode = node.nextNode;
    node.nextNode.prevNode = node.prevNode;
    if (index==0) {
        self.firstNode = node.nextNode;
    } else if (index==self.size-1) {
        self.lastNode = node.prevNode;
    }
    self.size--;
    id obj = node.element;
    node = nil;
    return obj;
}
- (NSInteger)indexOfObject:(id)anObject{
    NSInteger runNum = self.size;
    SFTwowayCircleLinkedNode *node = self.firstNode;
    while (runNum>0) {
        if ([node.element isEqual:anObject]) {
            break;
        }
        node = node.nextNode;
        runNum--;
    }
    return self.size-runNum;
}
- (id)current{
    if (self.currentIndex>=self.size) {
        self.currentIndex = 0;
    }
    if (self.currentIndex == 0 && self.size==0) {
        return nil;
    }
    SFTwowayCircleLinkedNode *oldNode = [self getNodeWithIndex:self.currentIndex];
    return oldNode.element;
}
- (id)next{
    self.currentIndex++;
    if (self.currentIndex>=self.size) {
        self.currentIndex = 0;
    }
    if (self.currentIndex == 0 && self.size==0) {
        return nil;
    }
    SFTwowayCircleLinkedNode *oldNode = [self getNodeWithIndex:self.currentIndex];
    return oldNode.element;
}
- (id)prev{
    self.currentIndex--;
    if (self.currentIndex<0) {
        self.currentIndex = self.size-1;
    }
    if (self.currentIndex == 0 && self.size==0) {
        return nil;
    }
    SFTwowayCircleLinkedNode *oldNode = [self getNodeWithIndex:self.currentIndex];
    return oldNode.element;
}
- (NSString *)description{
    SFTwowayCircleLinkedNode *node = self.firstNode;
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

