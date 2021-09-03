//
//  SFSingleLinkedList.m
//  ApiTestDemo
//
//  Created by lurich on 2021/8/30.
//

#import "SFSingleCircleLinkedList.h"

@interface SFSingleCircleLinkedNode : NSObject

@property (nonatomic) id _Nonnull element;
@property (nonatomic, strong) SFSingleCircleLinkedNode * _Nullable nextNode;

@end

@implementation SFSingleCircleLinkedNode

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

@interface SFSingleCircleLinkedList()

@property (nonatomic, strong) SFSingleCircleLinkedNode *firstNode;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation SFSingleCircleLinkedList

- (instancetype)init{
    self = [super init];
    if (self) {
        self.size = 0;
        self.currentIndex = 0;
        self.firstNode = nil;
    }
    return self;
}

- (void)clear{
    self.size = 0;
    self.firstNode.nextNode = nil;
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
- (id)getObjectAtIndex:(NSInteger)index{
    SFSingleCircleLinkedNode *node = [self getNodeAtIndex:index];
    return !node?node:node.element;
}
- (void)setObject:(id)anObject AtIndex:(NSInteger)index{
    SFSingleCircleLinkedNode *newNode = [[SFSingleCircleLinkedNode alloc] init];
    newNode.element = anObject;
    if (index==0) {
        newNode.nextNode = self.firstNode;
        self.firstNode = newNode;
    } else {
        SFSingleCircleLinkedNode *node = [self getNodeAtIndex:index-1];
        newNode.nextNode = node.nextNode;
        node.nextNode = newNode;
    }
    self.size ++;
}
- (id)removeObjectAtIndex:(NSUInteger)index{
    if(index>=self.size || index<0) NSAssert(NO, @"数组越界");
    if (index==0) {
        SFSingleCircleLinkedNode *tmpNode = self.firstNode;
        self.firstNode = self.firstNode.nextNode;
        self.size--;
        return tmpNode.element;
    } else if (index==self.size-1) {
        SFSingleCircleLinkedNode *proNode = [self getNodeAtIndex:index-1];
        SFSingleCircleLinkedNode *tmpNode = proNode.nextNode;
        proNode.nextNode = self.firstNode;
        self.size--;
        return tmpNode.element;
    } else {
        SFSingleCircleLinkedNode *proNode = [self getNodeAtIndex:index-1];
        SFSingleCircleLinkedNode *tmpNode = proNode.nextNode;
        proNode.nextNode = proNode.nextNode.nextNode;
        self.size--;
        return tmpNode.element;
    }
}
- (SFSingleCircleLinkedNode *)getNodeAtIndex:(NSUInteger)index{
    if(index>=self.size || index<0) NSAssert(NO, @"数组越界");
    SFSingleCircleLinkedNode *node = self.firstNode;
    while (index!=0) {
        node = node.nextNode;
        index--;
    }
    return node;
}
- (NSInteger)indexOfObject:(id)anObject{
    SFSingleCircleLinkedNode *node = self.firstNode;
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
- (id)current{
    if (self.currentIndex>=self.size) {
        self.currentIndex = 0;
    }
    if (self.currentIndex == 0 && self.size==0) {
        return nil;
    }
    SFSingleCircleLinkedNode *oldNode = [self getNodeAtIndex:self.currentIndex];
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
    SFSingleCircleLinkedNode *oldNode = [self getNodeAtIndex:self.currentIndex];
    return oldNode.element;
}
- (NSString *)description{
    SFSingleCircleLinkedNode *node = self.firstNode;
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
