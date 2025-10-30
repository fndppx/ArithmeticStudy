#import "ArithmeticLearnOC.h"

// 链表节点实现
@implementation Node

- (instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    if (self) {
        _value = value;
        _next = nil;
        _pre = nil;
    }
    return self;
}

@end

// 栈实现
@interface Stack ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation Stack

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
    }
    return self;
}

- (void)push:(id)item {
    [self.items addObject:item];
}

- (id)pop {
    if ([self.items count] == 0) {
        return nil;
    }
    id lastItem = [self.items lastObject];
    [self.items removeLastObject];
    return lastItem;
}

- (id)peek {
    return [self.items lastObject];
}

- (BOOL)isEmpty {
    return [self.items count] == 0;
}

- (NSInteger)size {
    return [self.items count];
}

- (void)clear {
    [self.items removeAllObjects];
}

- (void)printStack {
    NSLog(@"%@", self.items);
}

@end

@interface ArithmeticLearnOC ()

@property (nonatomic, strong) NSMutableArray *result;

@end

@implementation ArithmeticLearnOC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"算法学习OC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化结果数组
    self.result = [NSMutableArray array];
    
    // 创建链表
    Node *node1 = [[Node alloc] initWithValue:1];
    Node *node2 = [[Node alloc] initWithValue:2];
    Node *node3 = [[Node alloc] initWithValue:3];
    Node *node4 = [[Node alloc] initWithValue:4];
    Node *node5 = [[Node alloc] initWithValue:5];
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    node4.next = node5;
    
    // 打印链表
    Node *current = node1;
    while (current) {
        NSLog(@"%ld", (long)current.value);
        current = current.next;
    }
    
    // 1.反转链表
    Node *reversedList = [self reveseList:node1];
    if (reversedList) {
        current = reversedList;
        while (current) {
            NSLog(@"%ld", (long)current.value);
            current = current.next;
        }
    }
    
    // 2.环形链表
    if ([self hasCycle:node1]) {
        NSLog(@"环形链表");
    } else {
        NSLog(@"不是环形链表");
    }
    
    // 8.找到最长字符串不重复子串
    NSString *longestSubstring = [self findLongestSubstring:@"ajbcdefgaklo"];
    NSLog(@"最长字符串不重复子串: %@", longestSubstring);
    
    // 测试回溯算法
    NSMutableArray *path = [NSMutableArray array];
    NSArray *choice = @[@"apple", @"banana", @"cherry"];
    [self backTrackWithPath:path choice:choice];
    NSLog(@"组合结果: %@", self.result);

    // 反转双链表
    Node *node6 = [[Node alloc] initWithValue:1];
    Node *node7 = [[Node alloc] initWithValue:2];
    Node *node8 = [[Node alloc] initWithValue:3];
    node6.next = node7;
    node7.next = node8;
    node8.next = nil;
    node6.pre = nil;
    node7.pre = node6;
    node8.pre = node7;
    Node *reversedDoubleList = [self reverseLink:node6];
    if (reversedDoubleList) {
        current = reversedDoubleList;
        while (current) {
            NSLog(@"%ld", (long)current.value);
            current = current.next;
        }
    }
}

// 1.反转链表
- (Node *)reveseList:(Node *)head {
    Node *prev = nil;
    Node *current = head;
    while (current) {
        Node *next = current.next;
        current.next = prev;
        prev = current;
        current = next;
    }
    return prev;
}

// 2.环形链表
- (BOOL)hasCycle:(Node *)head {
    Node *slow = head;
    Node *fast = head.next;
    while (fast && fast.next) {
        if (slow == fast) {
            return YES;
        }
        slow = slow.next;
        fast = fast.next.next;
    }
    return NO;
}

// 3.合并两个有序链表
- (Node *)mergeTwoLists:(Node *)list1 list2:(Node *)list2 {
    Node *dummy = [[Node alloc] initWithValue:0];
    Node *current = dummy;
    Node *l1 = list1;
    Node *l2 = list2;
    
    while (l1 && l2) {
        if (l1.value < l2.value) {
            current.next = l1;
            l1 = l1.next;
        } else {
            current.next = l2;
            l2 = l2.next;
        }
        current = current.next;
    }
    
    current.next = l1 ? l1 : l2;
    return dummy.next;
}

// 4.a b 两个值交换 不借助第三个变量
- (void)swapPairsWithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    NSInteger a = value1;
    NSInteger b = value2;
    a = a + b;
    b = a - b;
    a = a - b;
    NSLog(@"a: %ld, b: %ld", (long)a, (long)b);
}

// 用位运算
- (void)swapPairs2WithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    NSInteger a = value1;
    NSInteger b = value2;
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    NSLog(@"a: %ld, b: %ld", (long)a, (long)b);
}

// 6.找到view的公共父视图
- (UIView *)findCommonSuperView:(UIView *)view1 view2:(UIView *)view2 {
    NSMutableArray *view1Superviews = [NSMutableArray array];
    NSMutableArray *view2Superviews = [NSMutableArray array];
    
    UIView *currentView = view1;
    while (currentView.superview) {
        [view1Superviews addObject:currentView.superview];
        currentView = currentView.superview;
    }
    
    currentView = view2;
    while (currentView.superview) {
        [view2Superviews addObject:currentView.superview];
        currentView = currentView.superview;
    }
    
    for (UIView *view1Super in view1Superviews) {
        for (UIView *view2Super in view2Superviews) {
            if (view1Super == view2Super) {
                return view1Super;
            }
        }
    }
    return nil;
}

// 8.找到最长字符串不重复子串
- (NSString *)findLongestSubstring:(NSString *)s {
    NSInteger maxLength = 0;
    NSString *maxSubstring = @"";
    NSMutableDictionary *charIndexMap = [NSMutableDictionary dictionary];
    
    NSInteger left = 0;
    // 左右滑动窗口
    for (NSInteger right = 0; right < [s length]; right++) {
        unichar char_right = [s characterAtIndex:right];
        NSNumber *lastIndex = charIndexMap[@(char_right)];
        
        if (lastIndex) {
            // 重复出现左侧右移一位（上次保存的左侧和当前对比 取最大）
            left = MAX(left, [lastIndex integerValue] + 1);
        }
        
        // 右侧减去左侧差值+1 因为索引是0开始
        NSInteger currentLength = right - left + 1;
        
        // 更新最大长度
        if (currentLength > maxLength) {
            maxLength = currentLength;
            maxSubstring = [s substringWithRange:NSMakeRange(left, currentLength)];
        }
        
        // 记录当前位置
        charIndexMap[@(char_right)] = @(right);
    }
    
    return maxSubstring;
}

// 9.字符串反转双指针
- (NSString *)reverseString:(NSString *)s {
    NSMutableString *chars = [NSMutableString stringWithString:s];
    NSInteger left = 0;
    NSInteger right = [chars length] - 1;
    
    while (left < right) {
        unichar leftChar = [chars characterAtIndex:left];
        unichar rightChar = [chars characterAtIndex:right];
        
        [chars replaceCharactersInRange:NSMakeRange(left, 1) withString:[NSString stringWithCharacters:&rightChar length:1]];
        [chars replaceCharactersInRange:NSMakeRange(right, 1) withString:[NSString stringWithCharacters:&leftChar length:1]];
        
        left++;
        right--;
    }
    return chars;
}

// 10.字符串反转栈
- (NSString *)reverseString2:(NSString *)s {
    Stack *stack = [[Stack alloc] init];
    for (NSInteger i = 0; i < [s length]; i++) {
        unichar c = [s characterAtIndex:i];
        [stack push:@(c)];
    }
    
    NSMutableString *result = [NSMutableString string];
    while (![stack isEmpty]) {
        NSNumber *charNum = [stack pop];
        unichar c = [charNum unsignedShortValue];
        [result appendString:[NSString stringWithCharacters:&c length:1]];
    }
    return result;
}

// 11.回文字符串
- (BOOL)isPalindrome:(NSString *)s {
    NSInteger left = 0;
    NSInteger right = [s length] - 1;
    
    while (left < right) {
        if ([s characterAtIndex:left] != [s characterAtIndex:right]) {
            return NO;
        }
        left++;
        right--;
    }
    return YES;
}

// 12.有效括号匹配
- (BOOL)isValid:(NSString *)s {
    Stack *stack = [[Stack alloc] init];
    NSDictionary *pairs = @{
        @")": @"(",
        @"]": @"[",
        @"}": @"{"
    };
    
    for (NSInteger i = 0; i < [s length]; i++) {
        NSString *char_str = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
        if ([char_str isEqualToString:@"("] || [char_str isEqualToString:@"["] || [char_str isEqualToString:@"{"]) {
            [stack push:char_str];
        } else {
            if ([stack isEmpty]) {
                return NO;
            }
            NSString *top = [stack peek];
            if ([top isEqualToString:pairs[char_str]]) {
                [stack pop];
            } else {
                return NO;
            }
        }
    }
    return [stack isEmpty];
}

// 13.字符串中唯一的第一个不重复字符
- (NSString *)firstUniqChar:(NSString *)s {
    NSMutableArray *charOrder = [NSMutableArray array];
    NSMutableDictionary *charCount = [NSMutableDictionary dictionary];
    
    // 第一次遍历记录每个字符出现次数和顺序
    for (NSInteger i = 0; i < [s length]; i++) {
        NSString *char_str = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
        if (!charCount[char_str]) {
            [charOrder addObject:char_str];
        }
        NSNumber *count = charCount[char_str];
        charCount[char_str] = @(count ? [count integerValue] + 1 : 1);
    }
    
    // 按照字符出现顺序查找第一个只出现一次的字符
    for (NSString *char_str in charOrder) {
        if ([charCount[char_str] integerValue] == 1) {
            return char_str;
        }
    }
    return nil;
}

// 14.两数之和
- (NSArray *)twoSum:(NSArray *)nums target:(NSInteger)target {
    NSMutableDictionary *numDict = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 0; i < [nums count]; i++) {
        NSNumber *num = nums[i];
        NSNumber *complement = @(target - [num integerValue]);
        NSNumber *complementIndex = numDict[complement];
        
        if (complementIndex) {
            return @[complementIndex, @(i)];
        }
        numDict[num] = @(i);
    }
    return @[];
}

// 15.凑零钱问题
- (NSInteger)coinChange:(NSArray *)coins amount:(NSInteger)amount {
    NSMutableArray *dp = [NSMutableArray arrayWithCapacity:amount + 1];
    for (NSInteger i = 0; i <= amount; i++) {
        [dp addObject:@(amount + 1)];
    }
    dp[0] = @(0);
    
    for (NSInteger i = 1; i <= amount; i++) {
        for (NSNumber *coin in coins) {
            if ([coin integerValue] <= i) {
                NSInteger value = MIN([dp[i] integerValue], 
                                    [dp[i - [coin integerValue]] integerValue] + 1);
                dp[i] = @(value);
            }
        }
    }
    
    return [dp[amount] integerValue] > amount ? -1 : [dp[amount] integerValue];
}

// 回溯算法实现
- (void)backTrackWithPath:(NSMutableArray *)path choice:(NSArray *)choice {
    if (path.count == 3) {
        [self.result addObject:[path copy]];
        return;
    }
    
    for (NSInteger i = 0; i < choice.count; i++) {
        NSString *fruit = choice[i];
        [path addObject:fruit];
        
        NSMutableArray *choiceArr = [choice mutableCopy];
        [choiceArr removeObjectAtIndex:i];
        
        [self backTrackWithPath:path choice:choiceArr];
        
        [path removeLastObject];
    }
}

// 反转双链表
- (Node *)reverseLink:(Node *)head {
    Node *temp = nil;
    Node *current = head;
    
    while (current != nil) {
        // 保存当前节点的前后指针
        temp = current.pre;
        current.pre = current.next;
        current.next = temp;
        
        // 移动到下一个节点前先保存
        current = current.pre; // 因为current.pre已经指向了next
    }
    
    // 找到新的头节点
    // 由于我们在循环中不断移动current直到nil，此时temp指向原链表的最后一个节点
    // temp.pre指向倒数第二个节点，这个节点将成为新的头节点
    if (temp != nil) {
        head = temp.pre;
    }
    
    return head;
}

// 螺旋矩阵
// 根据题目示例 matrix = [[1,2,3],[4,5,6],[7,8,9]] 的对应输出 [1,2,3,6,9,8,7,4,5] 可以发现，顺时针打印矩阵的顺序是 “从左向右、从上向下、从右向左、从下向上” 循环。

// 核心思路：使用四个边界指针(top, bottom, left, right)，按照顺时针方向依次遍历
// 1. 从左到右遍历上边界，然后上边界下移
// 2. 从上到下遍历右边界，然后右边界左移
// 3. 从右到左遍历下边界，然后下边界上移
// 4. 从下到上遍历左边界，然后左边界右移
// 重复上述过程直到所有元素都被访问
- (NSArray *)spiralMatrix:(NSArray *)matrix {
    if (matrix.count == 0 || [matrix[0] count] == 0) {
        return @[];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    NSInteger top = 0;
    NSInteger bottom = [matrix count] - 1;
    NSInteger left = 0;
    NSInteger right = [matrix[0] count] - 1;

    while (top <= bottom && left <= right) {
        // 从左到右遍历上边界
        for (NSInteger i = left; i <= right; i++) {
            [result addObject:matrix[top][i]];
        }
        top++;
        
        // 从上到下遍历右边界
        for (NSInteger i = top; i <= bottom; i++) {
            [result addObject:matrix[i][right]];
        }
        right--;
        
        // 从右到左遍历下边界（如果还有行）
        if (top <= bottom) {
            for (NSInteger i = right; i >= left; i--) {
                [result addObject:matrix[bottom][i]];
            }
            bottom--;
        }
        
        // 从下到上遍历左边界（如果还有列）
        if (left <= right) {
            for (NSInteger i = bottom; i >= top; i--) {
                [result addObject:matrix[i][left]];
            }
            left++;
        }
    }
    
    return result;
}

@end
