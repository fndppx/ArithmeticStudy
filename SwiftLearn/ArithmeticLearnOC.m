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

    NSInteger maxArea = [self maxArea:@[@(1), @(8), @(6), @(2), @(5), @(4), @(8), @(3), @(7)]];
    NSLog(@"maxArea: %ld", (long)maxArea);

    NSArray *threeSumResult = [self threeSum:@[@(-1), @(0), @(1), @(2), @(-1), @(-4)]];
    NSLog(@"threeSumResult: %@", threeSumResult);
    if (threeSumResult.count > 0) {
        for (NSArray *array in threeSumResult) {
            NSLog(@"%@", array);
        }
    }

    NSArray *findAnagramsResult = [self findAnagrams:@"cbaebabacd" p:@"abc"];
    NSLog(@"findAnagramsResult: %@", findAnagramsResult);
    if (findAnagramsResult.count > 0) {
        for (NSNumber *index in findAnagramsResult) {
            NSLog(@"%ld", (long)[index integerValue]);
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

// 14.两数之和 字典保存第一次出现的值，后续target-第一个值=第二个值，则返回两个值的索引
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

//数组中重复的数字
- (NSInteger)findRepeatNumber:(NSArray *)nums {
    NSMutableDictionary *numDict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < [nums count]; i++) {
        NSNumber *num = nums[i];
        if (numDict[num]) {
            return [num integerValue];
        }
        numDict[num] = @(i);
    }
    return -1;
}

//49. 字母异位词分组
- (NSArray *)groupAnagrams:(NSArray *)strs {
    NSMutableDictionary *anagramsDict = [NSMutableDictionary dictionary];
    
    for (NSString *str in strs) {
        // 将字符串转换为字符数组并排序
        NSMutableArray *chars = [NSMutableArray array];
        for (NSInteger i = 0; i < [str length]; i++) {
            [chars addObject:[NSString stringWithFormat:@"%c", [str characterAtIndex:i]]];
        }
        [chars sortUsingSelector:@selector(compare:)];
        NSString *sortedStr = [chars componentsJoinedByString:@""];
        
        // 如果字典中没有这个key，创建一个新的数组
        if (!anagramsDict[sortedStr]) {
            anagramsDict[sortedStr] = [NSMutableArray array];
        }
        [anagramsDict[sortedStr] addObject:str];
    }
    
    return [anagramsDict allValues];
}

//输入：nums = [100,4,200,1,3,2]
//输出：4
//解释：最长数字连续序列是 [1, 2, 3, 4]。它的长度为 4。
//
//输入：nums = [0,3,7,2,5,8,4,6,0,1]
//输出：9

- (NSInteger)longestConsecutive:(NSArray *)nums {
    NSMutableSet *set = [NSMutableSet setWithArray:nums];
    
    NSInteger longgestNum = 0;
    for (NSNumber *num in set) {
        NSInteger numValue = [num integerValue];
        if (![set containsObject:@(numValue - 1)]) {
            
            NSInteger curStreak = 1;
            
            while ([set containsObject:@(numValue + 1)]) {
                numValue+=1;
                curStreak+=1;
            }
            
            longgestNum = MAX(longgestNum, curStreak);

        }
    }
    
    return longgestNum;
}

//给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
//
//请注意 ，必须在不复制数组的情况下原地对数组进行操作。
- (void)moveZeroes:(NSMutableArray *)nums {
    NSInteger i = 0;
    for (NSInteger j = 0; j < nums.count; j++) {
        if ([nums[j] integerValue] != 0) {
            nums[i] = nums[j];
            i++;
        }
    }
    for (NSInteger j = i; j < nums.count; j++) {
        nums[j] = @(0);
    }
}

//盛最多水的容器
- (NSInteger)maxArea:(NSArray *)height {
    if (height.count == 0) {
        return 0;
    }
    NSInteger left = 0;
    NSInteger right = height.count - 1;
    NSInteger maxArea = 0;
    while (left < right) {
        NSInteger minHeight = MIN([height[left] integerValue], [height[right] integerValue]);
        maxArea = MAX(maxArea, minHeight * (right - left));
        if ([height[left] integerValue] < [height[right] integerValue]) {
            left++;
        } else {
            right--;
        }
    }
    return maxArea;
}   


// 给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。

// 注意：答案中不可以包含重复的三元组。
// 示例 1：

// 输入：nums = [-1,0,1,2,-1,-4]
// 输出：[[-1,-1,2],[-1,0,1]]
// 解释：
// nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。
// nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。
// nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。
// 不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。
// 注意，输出的顺序和三元组的顺序并不重要。
// 示例 2：

// 输入：nums = [0,1,1]
// 输出：[]
// 解释：唯一可能的三元组和不为 0 。

// 三数之和算法思路：
// 1. 首先对数组进行排序，这样可以使用双指针技巧
// 2. 固定第一个数nums[i]，然后在剩余数组中寻找两个数使得三数之和为0
// 3. 使用双指针left和right分别指向i+1和数组末尾
// 4. 如果sum == 0，找到一个解；如果sum < 0，left右移；如果sum > 0，right左移
// 5. 为了避免重复解，需要跳过相同的元素
- (NSArray *)threeSum:(NSArray *)nums {
    if (nums.count < 3) {
        return @[];
    }
    // 需要创建可变数组来排序，因为NSArray是不可变的
    NSMutableArray *mutableNums = [nums mutableCopy];
    [mutableNums sortUsingSelector:@selector(compare:)];
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < mutableNums.count - 2; i++) { // 修改循环条件，避免越界
        if (i > 0 && [mutableNums[i] integerValue] == [mutableNums[i - 1] integerValue]) {
            continue;
        }
        NSInteger left = i + 1;
        NSInteger right = mutableNums.count - 1;
        while (left < right) {
            NSInteger sum = [mutableNums[i] integerValue] + [mutableNums[left] integerValue] + [mutableNums[right] integerValue];
            if (sum == 0) {
                [result addObject:@[mutableNums[i], mutableNums[left], mutableNums[right]]]; // 直接使用NSNumber对象
                while (left < right && [mutableNums[left] integerValue] == [mutableNums[left + 1] integerValue]) {
                    left++;
                }
                while (left < right && [mutableNums[right] integerValue] == [mutableNums[right - 1] integerValue]) {
                    right--;
                }
                left++;
                right--;
            } else if (sum < 0) {
                left++;
            } else {
                right--;
            }
        }
    }
    return result;
}
//cbaebabacd" :@"abc
// 给定两个字符串 s 和 p，找到 s 中所有 p 的 异位词 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。
- (NSArray *)findAnagrams:(NSString *)s p:(NSString *)p {
    NSMutableArray *result = [NSMutableArray array];
    
    if (s.length < p.length) {
        return result;
    }
    
    // 创建字符频率字典
    NSMutableDictionary *pFreq = [NSMutableDictionary dictionary];
    NSMutableDictionary *windowFreq = [NSMutableDictionary dictionary];
    
    // 统计p中每个字符的频率
    for (NSInteger i = 0; i < p.length; i++) {
        NSString *char1 = [NSString stringWithFormat:@"%c", [p characterAtIndex:i]];
        NSNumber *count = pFreq[char1];
        pFreq[char1] = @((count ? count.integerValue : 0) + 1);
    }
    
    // 滑动窗口
    NSInteger windowSize = p.length;
    
    // 初始化第一个窗口
    for (NSInteger i = 0; i < windowSize; i++) {
        NSString *char1 = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
        NSNumber *count = windowFreq[char1];
        windowFreq[char1] = @((count ? count.integerValue : 0) + 1);
    }
    
    // 检查第一个窗口
    if ([pFreq isEqualToDictionary:windowFreq]) {
        [result addObject:@(0)];
    }
    
    // 滑动窗口
    for (NSInteger i = windowSize; i < s.length; i++) {
        // 添加新字符
        NSString *newChar = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
        NSNumber *newCount = windowFreq[newChar];
        windowFreq[newChar] = @((newCount ? newCount.integerValue : 0) + 1);
        
        // 移除旧字符
        NSString *oldChar = [NSString stringWithFormat:@"%c", [s characterAtIndex:i - windowSize]];
        NSNumber *oldCountNum = windowFreq[oldChar];
        NSInteger oldCount = (oldCountNum ? oldCountNum.integerValue : 0) - 1;
        if (oldCount == 0) {
            [windowFreq removeObjectForKey:oldChar];
        } else {
            windowFreq[oldChar] = @(oldCount);
        }
        
        // 检查当前窗口
        if ([pFreq isEqualToDictionary:windowFreq]) {
            [result addObject:@(i - windowSize + 1)];
        }
    }
    
    return result;
}

// 给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

// 请你将两个数相加，并以相同形式返回一个表示和的链表。

// 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

- (Node *)addTwoNumbers:(Node *)l1 l2:(Node *)l2 {
    Node *dummy = [[Node alloc] initWithValue:0];
    Node *current = dummy;
    NSInteger carry = 0;

    // 遍历两条链表，逐位相加并处理进位
    while (l1 != nil || l2 != nil || carry != 0) {
        NSInteger x = l1 != nil ? l1.value : 0;
        NSInteger y = l2 != nil ? l2.value : 0;
        NSInteger sum = x + y + carry;

        carry = sum / 10;
        current.next = [[Node alloc] initWithValue:(sum % 10)];
        current = current.next;

        if (l1 != nil) {
            l1 = l1.next;
        }
        if (l2 != nil) {
            l2 = l2.next;
        }
    }

    return dummy.next;
}

// 删除链表倒数第N个节点
- (Node *)removeNthFromEnd:(Node *)head n:(NSInteger)n {
    Node *dummy = [[Node alloc] initWithValue:0];
    dummy.next = head;
    Node *first = dummy;
    Node *second = dummy;
    // 这里 i < n + 1 的原因，是要让 first 指针比 second 指针多走 n+1 步（含 dummy 节点），这样 first 和 second 之间就相隔 n 个节点。
    // 当 first 到达链表末尾时，second 指向要删除节点的前一个位置，从而便于删除倒数第 n 个节点。
    for (NSInteger i = 0; i < n + 1; i++) {
        first = first.next;
    }
    while (first != nil) {
        first = first.next;
        second = second.next;
    }
    second.next = second.next.next;
    return dummy.next;
}

//两两交换链表中的节点
- (Node *)swapPairs:(Node *)head {
    Node *dummy = [[Node alloc] initWithValue:0];
    dummy.next = head;
    Node *current = dummy;
    while (current.next != nil && current.next.next != nil) {
        Node *first = current.next;
        Node *second = current.next.next;
        first.next = second.next;
        second.next = first;
        current.next = second;
        current = first;
    }
    return dummy.next;
}

//二叉树的中序遍历
- (void)inorderTraversal:(TreeNode *)root {
    if (root == nil) {
        return;
    }
    inorderTraversal(root.left);
    NSLog(@"%ld", (long)root.value);
    inorderTraversal(root.right);
}

//二叉树的最大深度
- (NSInteger)maxDepth:(TreeNode *)root {
    if (root == nil) {
        return 0;
    }
    return MAX(maxDepth(root.left), maxDepth(root.right)) + 1;
}


//反转二叉树
- (TreeNode *)invertTree:(TreeNode *)root {
    if (root == nil) {
        return nil;
    }
    TreeNode *left = root.left;
    TreeNode *right = root.right;
    root.left = invertTree(right);
    root.right = invertTree(left);
    return root;
}

//对称二叉树
- (BOOL)isSymmetric:(TreeNode *)root {
    return [self isMirror:root.left right:root.right];
}

- (BOOL)isMirror:(TreeNode *)left right:(TreeNode *)right {
    if (left == nil && right == nil) {
        return YES;
    }
    if (left == nil || right == nil) {
        return NO;
    }
    if (left.value != right.value) {
        return NO;
    }
    return [self isMirror:left.left right:right.right] && [self isMirror:left.right right:right.left];
}
    
//二叉树的直径
- (NSInteger)diameterOfBinaryTree:(TreeNode *)root {
    if (root == nil) {
        return 0;
    }
    return MAX(diameterOfBinaryTree(root.left), diameterOfBinaryTree(root.right)) + 1;
}

//二叉树的层序遍历
- (void)levelOrderTraversal:(TreeNode *)root {
    if (root == nil) {
        return;
    }
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:root];
    while (queue.count > 0) {
        TreeNode *node = [queue firstObject];
        NSLog(@"%ld", (long)node.value);
        if (node.left != nil) {
            [queue addObject:node.left];
        }
        if (node.right != nil) {
            [queue addObject:node.right];
        }
        [queue removeObjectAtIndex:0]; // 移除第一个元素    
    }
}

//将有序数组转换为二叉搜索树
- (TreeNode *)sortedArrayToBST:(NSArray *)nums {
    if (nums.count == 0) {
        return nil;
    }
    return [self sortedArrayToBST:nums index:(nums.count - 1) / 2];
}

- (TreeNode *)sortedArrayToBST:(NSArray *)nums index:(NSInteger)index {
    if (index < 0 || index >= nums.count) {
        return nil;
    }
    TreeNode *node = [[TreeNode alloc] initWithValue:[nums[index] integerValue]];
    node.left = [self sortedArrayToBST:nums index:(index - 1) / 2];
    node.right = [self sortedArrayToBST:nums index:(index + 1) / 2];
    return node;
}

//从前序和中序遍历序列构造二叉树
- (TreeNode *)buildTree:(NSArray *)preorder inorder:(NSArray *)inorder {
    if (preorder.count == 0 || inorder.count == 0) {
        return nil;
    }   
    return [self buildTree:preorder preStart:0 preEnd:preorder.count - 1 inorder:inorder inStart:0 inEnd:inorder.count - 1];
}

- (TreeNode *)buildTree:(NSArray *)preorder index:(NSInteger)index inorder:(NSArray *)inorder index:(NSInteger)index {
    if (index < 0 || index >= preorder.count) {
        return nil;
    }
    TreeNode *node = [[TreeNode alloc] initWithValue:[preorder[index] integerValue]];
    node.left = [self buildTree:preorder index:index + 1 inorder:inorder index:index];
    node.right = [self buildTree:preorder index:index + 1 inorder:inorder index:index];
    return node;
}

//搜索插入位置
- (NSInteger)searchInsert:(NSArray *)nums target:(NSInteger)target {
    if (nums.count == 0) {
        return 0;
    }
    return [self searchInsert:nums target:target index:0];
}

- (NSInteger)searchInsert:(NSArray *)nums target:(NSInteger)target index:(NSInteger)index {
    if (index < 0 || index >= nums.count) {
        return index;
    }
    if ([nums[index] integerValue] == target) {
        return index;
    }
    if ([nums[index] integerValue] > target) {
        return [self searchInsert:nums target:target index:index - 1];
    }
    return [self searchInsert:nums target:target index:index + 1];
}

//买卖股票的最佳时机
- (NSInteger)maxProfit:(NSArray *)prices {
    NSInteger minPrice = NSIntegerMax, maxProfit = 0;
    for (NSNumber *price in prices) {
        minPrice = MIN(minPrice, price.integerValue);
        maxProfit = MAX(maxProfit, price.integerValue - minPrice);
    }
    return maxProfit;
}

//只出现一次的数字
- (NSInteger)singleNumber:(NSArray *)nums {
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    for (NSNumber *num in nums) {
        NSNumber *count = map[num];
        if (count) {
            map[num] = @(count.integerValue + 1);
        } else {
            map[num] = @(1);
        }
    }
    for (NSNumber *key in map) {
        if ([map[key] integerValue] == 1) {
            return key.integerValue;
        }
    }
    return 0;
}

//多数元素
- (NSInteger)majorityElement:(NSArray *)nums {
    NSInteger candidate = 0, count = 0;
    for (NSNumber *num in nums) {
        count += (count == 0 || candidate == num.integerValue) ? 1 : -1;
        if (count == 1) candidate = num.integerValue;
    }
    return candidate;
}
@end
