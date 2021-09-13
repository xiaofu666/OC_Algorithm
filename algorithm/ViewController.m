//
//  ViewController.m
//  algorithm
//
//  Created by lurich on 2021/9/3.
//

#import "ViewController.h"
#import "SFStack.h"
#import "SFQueue.h"
#import "SFSingleLinkedList.h"
#import "SFSingleCircleLinkedList.h"
#import "SFTwowayLinkedList.h"
#import "SFTwowayCircleLinkedList.h"
#import "MJBinaryTrees.h"
#import "BinarySearchTree.h"

#import "SFBubbleSort.h"
#import "SFSelectionSort.h"
#import "SFInsertionSort.h"
#import "SFMergeSort.h"
#import "SFQuickSort.h"
#import "SFShellSort.h"
#import "SFHeapSort.h"
#import "SFCountingSort.h"
#import "SFRadixSort.h"
#import "SFBinaryHeap.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tree];
}
- (void)tree{
    NSString *testStr = @"57, 56, 40, 18, 83, 76, 4, 17, 22, 36, 84, 14, 52, 74, 54, 5, 92, 70, 53, 24, 81, 2, 61, 31, 55, 100, 38, 77, 42, 50, 93, 34, 59, 65, 99, 97";
    NSMutableArray *numArray = [NSMutableArray arrayWithArray:[testStr componentsSeparatedByString:@","]];
    BinarySearchTree *tree = [BinarySearchTree tree];
    
    for (int i = 0; i < 100; i++) {
        NSNumber *random = @(arc4random_uniform(1000));
        [tree addObject:random];
        [numArray addObject:random];
    }
    
//    for (int i = 0; i < numArray.count; i++) {
//        NSString *str = numArray[i];
//        [tree addObject:@(str.integerValue)];
//    }
    
//    [tree addObject:@(31)];
//    [tree removeObject:@(69)];
    
    [tree removeObject:@(70)];
    [tree removeObject:@(36)];
    [tree removeObject:@(81)];
    [tree removeObject:@(40)];
    
    NSLog(@"numArray.count:%zd",[numArray count]);
    printf("------------------------------------------------------------------\n");
    [MJBinaryTrees println:tree];
    printf("------------------------------------------------------------------\n");
    
    NSArray *itemArr = [tree inorderTraversalWithObject:nil];
    NSLog(@"%@",[itemArr componentsJoinedByString:@","]);
    
//    NSLog(@"%@",[tree rootObject]);
    
//    [tree leftAndRightHeightWithObject:@(39)];
    
//    NSLog(@"%zd",[tree heightWithObject:@(43)]);
//    NSLog(@"%zd",[tree heightWithObject:@(38)]);
//    NSLog(@"%zd",[tree heightWithObject:@(29)]);
//    NSLog(@"%zd",[tree heightWithObject:@(45)]);
    
//    [tree preorderTraversalWithObject:nil];
//    [tree inorderTraversalWithObject:nil]
//    [tree postorderTraversalWithObject:nil];
//    [tree levelOrderTraversalWithObject:nil];
//    [tree clear];
}
- (void)binaryHeap{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 20; i++) {
        NSNumber *random = @(arc4random_uniform(1000));
        [array addObject:random];
    }
    SFBinaryHeap *heap = [SFBinaryHeap heapWithArray:array ComparatorBlock:^int(NSNumber *e1, NSNumber *e2) {
        return e2.integerValue-e1.integerValue;
    }];
    
    printf("------------------------------------------------------------------\n");
    [MJBinaryTrees println:heap style:MJPrintStyleInorder];
    printf("------------------------------------------------------------------\n");
    
    [heap remove];
    
    printf("------------------------------------------------------------------\n");
    [MJBinaryTrees println:heap style:MJPrintStyleInorder];
    printf("------------------------------------------------------------------\n");
}
- (void)testSort{
    //获取一个邀请码
//    static const char randomStr[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//    NSString *str = @"";
//    for (int i=0; i<6; i++) {
//        char randowChar = randomStr[arc4random_uniform(36)];
//        str = [NSString stringWithFormat:@"%@%c",str,randowChar];
//    }
//    NSLog(@"%@",str);
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 20; i++) {
        NSNumber *random = @(arc4random_uniform(1000));
        [array addObject:random];
    }
    NSLog(@"排序前：%@",[array componentsJoinedByString:@","]);
    SFCountingSort *sort1 = [SFCountingSort new];
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
    NSArray *afterArray = [sort1 sortArray:array];
    time = [NSDate timeIntervalSinceReferenceDate] - time;
    NSLog(@"排序所消耗时间time = %f",time);
    NSLog(@"排序后：%@",[afterArray componentsJoinedByString:@"_"]);
}
- (void)twoWay{
    SFTwowayCircleLinkedList *list = [[SFTwowayCircleLinkedList alloc] init];
    for (int i=0; i<10; i++) {
        [list addObject:@(i+1)];
    }
    // 1 2 3 4 5 6 7 8 9 10
    NSLog(@"%@",list);
    [list removeObjectAtIndex:list.size-1];
    // 1 2 3 4 5 6 7 8 9
    NSLog(@"%@",list);
    [list removeObjectAtIndex:0];
    // 2 3 4 5 6 7 8 9
    NSLog(@"%@",list);
    [list removeObjectAtIndex:5];
    // 2 3 4 5 6 8 9
    NSLog(@"%@",list);
    NSLog(@"%@",[list getObjectAtIndex:list.size-1]);
    [list next];
    [list next];
    [list next];
    NSLog(@"list.current:%@",[list current]);//5
    // 2 3 4 5 6 8 9
    NSLog(@"%@",list);
    [list removeObjectAtIndex:3];
    // 2 3 4 6 8 9
    NSLog(@"%@",list);
    [list next];
    NSLog(@"list.current:%@",[list current]);//5
    [list clear];
    NSLog(@"%@",list);
    NSLog(@"list.current:%@",[list current]);//nil
    [list addObject:@(1)];
    NSLog(@"%@",list);
    NSLog(@"list.current:%@",[list current]);//1
    [list addObject:@(2)];
    NSLog(@"%@",list);
    [list next];
    NSLog(@"list.current:%@",[list current]);//2
    [list next];
    NSLog(@"list.current:%@",[list current]);//1
    [list next];
    NSLog(@"list.current:%@",[list current]);//2
    [list prev];
    NSLog(@"list.current:%@",[list current]);//1
    [list prev];
    NSLog(@"list.current:%@",[list current]);//2
    [list removeObjectAtIndex:0];
    NSLog(@"%@",list);
    [list prev];
    NSLog(@"list.current:%@",[list current]);//2
    [list next];
    NSLog(@"list.current:%@",[list current]);//2
    [list clear];
    NSLog(@"%@",list);
}
- (void)single{
    SFSingleCircleLinkedList *list = [[SFSingleCircleLinkedList alloc] init];
    for (int i=0; i<10; i++) {
        [list addObject:@(i+1)];
    }
    // 1 2 3 4 5 6 7 8 9 10
    NSLog(@"%@",list);
    [list removeObjectAtIndex:list.size-1];
    // 1 2 3 4 5 6 7 8 9
    NSLog(@"%@",list);
    [list removeObjectAtIndex:0];
    // 2 3 4 5 6 7 8 9
    NSLog(@"%@",list);
    [list removeObjectAtIndex:5];
    // 2 3 4 5 6 8 9
    NSLog(@"%@",list);
    [list addObject:@(11)];
    // 2 3 4 5 6 8 9 11
    NSLog(@"%@",list);
    [list setObject:@(5) AtIndex:5];
    // 2 3 4 5 6 5 8 9 11
    NSLog(@"%@",list);
    [list clear];
    NSLog(@"%@",list);
    [list addObject:@(1)];
    NSLog(@"%@",list);
    [list removeObjectAtIndex:0];
    NSLog(@"%@",list);
}
- (void)queue{
    SFQueue *queue = [[SFQueue alloc] init];
    for (int i=0; i<10; i++) {
        [queue enQueueObject:@(i+1)];
    }
    NSLog(@"first: %@",[queue first]);
    [queue deQueue];
    NSLog(@"size: %zd",[queue size]);
    [queue deQueue];
    NSLog(@"first: %@",[queue first]);
    NSLog(@"isEmpty:%d",[queue isEmpty]);
    [queue clear];
    NSLog(@"isEmpty:%d",[queue isEmpty]);
}
- (void)stack{
    SFStack *stack = [[SFStack alloc] init];
    for (int i=0; i<10; i++) {
        [stack pushObject:@(i+1)];
    }
    NSLog(@"first: %@",[stack peek]);
    [stack pop];
    [stack pop];
    NSLog(@"first: %@",[stack peek]);
    [stack pop];
    NSLog(@"size: %zd",[stack size]);
    [stack pushObject:@(11)];
    NSLog(@"isEmpty:%d",[stack isEmpty]);
    [stack clear];
    NSLog(@"isEmpty:%d",[stack isEmpty]);
}

@end
