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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tree];
}
- (void)tree{
    NSString *testStr = @"861,526,39,297,607,274,307,587,914,142,640,129,640,869,961,664,503,568,180,321,426,794,231,318,636,251,587,705,179,805,372,630,420,797,751,623,469,138,268,52,606,36,650,571,952,135,201,791";
    NSMutableArray *numArray = [NSMutableArray arrayWithArray:[testStr componentsSeparatedByString:@","]];
    BinarySearchTree *tree = [BinarySearchTree tree];
    
//    for (int i = 0; i < 30; i++) {
//        NSNumber *random = @(arc4random_uniform(1000));
//        [tree addObject:random];
//        [numArray addObject:random];
//    }
    
    for (int i = 0; i < numArray.count; i++) {
        NSString *str = numArray[i];
        [tree addObject:@(str.integerValue)];
    }
    
    [tree removeObject:@(321)];
    
//    [tree addObject:@(31)];
//    [tree removeObject:@(69)];
    NSLog(@"numArray.count:%zd",[numArray count]);
    printf("------------------------------------------------------------------\n");
    [MJBinaryTrees println:tree];
    printf("------------------------------------------------------------------\n");
    
    NSArray *itemArr = [tree inorderTraversalWithObject:nil];
    NSLog(@"%@",[itemArr componentsJoinedByString:@","]);

//    [tree removeObject:@(38)];
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
