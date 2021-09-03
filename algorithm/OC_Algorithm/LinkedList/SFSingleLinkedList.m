//
//  SFSingleLinkedList.m
//  ApiTestDemo
//
//  Created by lurich on 2021/8/30.
//

#import "SFSingleLinkedList.h"

@interface SFSingleLinkedNode : NSObject

@property (nonatomic) id _Nonnull element;
@property (nonatomic, strong) SFSingleLinkedNode * _Nullable nextNode;

@end

@implementation SFSingleLinkedNode

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

@interface SFSingleLinkedList()

@property (nonatomic, strong) SFSingleLinkedNode *firstNode;
@property (nonatomic, assign) NSInteger size;

@end

@implementation SFSingleLinkedList

- (instancetype)init{
    self = [super init];
    if (self) {
        self.size = 0;
        self.firstNode = nil;
    }
    return self;
}

- (void)clear{
    self.size = 0;
    self.firstNode = nil;
}
- (NSInteger)size{
    return _size;
}
//判断队列是否为空
- (BOOL)isEmpty{
    return self.size==0;
}
- (void)addObject:(id)anObject{
    SFSingleLinkedNode *newNode = [[SFSingleLinkedNode alloc] init];
    newNode.element = anObject;
    newNode.nextNode = nil;
    if (!_firstNode) {
        self.firstNode = newNode;
    } else {
        SFSingleLinkedNode *node = self.firstNode;
        while (node.nextNode) {
            node = node.nextNode;
        }
        node.nextNode = newNode;
    }
    self.size ++;
}
- (id)getObjectAtIndex:(NSInteger)index{
    SFSingleLinkedNode *node = [self getNodeAtIndex:index];
    return !node?node:node.element;
}
- (void)setObject:(id)anObject AtIndex:(NSInteger)index{
    SFSingleLinkedNode *newNode = [[SFSingleLinkedNode alloc] init];
    newNode.element = anObject;
    newNode.nextNode = nil;
    if (index==0) {
        newNode.nextNode = self.firstNode;
        self.firstNode = newNode;
    } else {
        SFSingleLinkedNode *node = [self getNodeAtIndex:index-1];
        newNode.nextNode = node.nextNode;
        node.nextNode = newNode;
    }
    self.size ++;
}
- (id)removeObjectAtIndex:(NSUInteger)index{
    if(index>=self.size || index<0) NSAssert(NO, @"数组越界");
    if (index==0) {
        SFSingleLinkedNode *tmpNode = self.firstNode;
        self.firstNode = self.firstNode.nextNode;
        self.size--;
        return tmpNode.element;
    } else if (index==self.size-1) {
        SFSingleLinkedNode *proNode = [self getNodeAtIndex:index-1];
        SFSingleLinkedNode *tmpNode = proNode.nextNode;
        proNode.nextNode = nil;
        self.size--;
        return tmpNode.element;
    } else {
        SFSingleLinkedNode *proNode = [self getNodeAtIndex:index-1];
        SFSingleLinkedNode *tmpNode = proNode.nextNode;
        proNode.nextNode = proNode.nextNode.nextNode;
        self.size--;
        return tmpNode.element;
    }
}
- (SFSingleLinkedNode *)getNodeAtIndex:(NSUInteger)index{
    if(index>=self.size || index<0) NSAssert(NO, @"数组越界");
    SFSingleLinkedNode *node = self.firstNode;
    while (index!=0) {
        node = node.nextNode;
        index--;
    }
    return node;
}
- (NSInteger)indexOfObject:(id)anObject{
    SFSingleLinkedNode *node = self.firstNode;
    NSInteger index = self.size;
    while (index!=0) {
        if ([node.element isEqual:anObject]) {
            break;
        }
        node = node.nextNode;
        index--;
    }
    return self.size-index;
}
- (NSString *)description{
    SFSingleLinkedNode *node = self.firstNode;
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
