//
//  SFCountingSort.m
//  algorithm
//
//  Created by lurich on 2021/9/5.
//

#import "SFCountingSort.h"

@implementation SFCountingSort

- (NSArray *)sortArray:(NSArray<id> *)array{
    self.mutableArray = [NSMutableArray arrayWithArray:array];
    //计数排序
//    [self sort1];
    //优化
    [self sort2];
    return self.mutableArray;
}
- (void)sort1{
    if (self.mutableArray.count==0) return;
    NSNumber *max = self.mutableArray[0];
    for (NSInteger i=1; i<self.mutableArray.count; i++) {
        if (max.integerValue<self.mutableArray[i].integerValue) {
            max = self.mutableArray[i];
        }
    }
    NSMutableArray<NSNumber *> *tmpArray = [NSMutableArray arrayWithCapacity:max.integerValue+1];
    for (NSInteger i=0; i<(max.integerValue+1); i++) {
        tmpArray[i] = @(0);
    }
    
    for (NSInteger i=0; i<self.mutableArray.count; i++) {
        NSInteger value = self.mutableArray[i].integerValue;
        NSInteger oldValue = tmpArray[value].integerValue;
        oldValue++;
        tmpArray[value] = @(oldValue);
    }

    NSInteger index = 0;
    for (NSInteger i=0; i<tmpArray.count; i++) {
        NSInteger tmpValue = tmpArray[i].integerValue;
        while (tmpValue>0) {
            self.mutableArray[index++] = @(i);
            tmpValue--;
        }
    }
}
- (void)sort2{
    if (self.mutableArray.count==0) return;
    NSNumber *max = self.mutableArray[0];
    NSNumber *min = self.mutableArray[0];
    for (NSInteger i=1; i<self.mutableArray.count; i++) {
        if (max.integerValue<self.mutableArray[i].integerValue) {
            max = self.mutableArray[i];
        }
        if (min.integerValue>self.mutableArray[i].integerValue) {
            min = self.mutableArray[i];
        }
    }
    NSMutableArray<NSNumber *> *tmpArray = [NSMutableArray arrayWithCapacity:max.integerValue-min.integerValue+1];
    for (NSInteger i=0; i<(max.integerValue-min.integerValue+1); i++) {
        tmpArray[i] = @(0);
    }
    
    for (NSInteger i=0; i<self.mutableArray.count; i++) {
        NSInteger value = self.mutableArray[i].integerValue-min.integerValue;
        NSInteger oldValue = tmpArray[value].integerValue;
        oldValue++;
        tmpArray[value] = @(oldValue);
    }
    // 累加次数
    for (NSInteger i = 1; i < tmpArray.count; i++) {
        tmpArray[i] = @(tmpArray[i - 1].integerValue+tmpArray[i].integerValue);
    }
    
    NSMutableArray<NSNumber *> *newArray = [NSMutableArray arrayWithCapacity:self.mutableArray.count];
    for (NSInteger i=0; i<self.mutableArray.count; i++) {
        newArray[i] = @(0);
    }
    
    for (NSInteger i=self.mutableArray.count-1; i>=0; i--) {
        //从后往前遍历，获取对应元素的下标
        NSInteger index = self.mutableArray[i].integerValue-min.integerValue;
        //元素所对应的累计下标值
        NSInteger sunIndex = tmpArray[index].integerValue;
        sunIndex --;
        newArray[sunIndex] = self.mutableArray[i];
    }
    self.mutableArray = [NSMutableArray arrayWithArray:newArray];
}

@end
