import UIKit

//单链表
class Node {
    var value: Int
    var next: Node?

    init(value: Int) {
        self.value = value
        self.next = nil
    }
}

class ArithmeticLearnVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "算法学习"
        self.view.backgroundColor = .white
        
        //创建链表
        let node1 = Node(value: 1)
        let node2 = Node(value: 2)
        let node3 = Node(value: 3)
        let node4 = Node(value: 4)
        let node5 = Node(value: 5)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        
        //打印链表
        var current: Node? = node1
        while let node = current {
            print(node.value)
            current = node.next
        }
        
        //1.反转链表
        if let reversedList = reveseList(head: node1) {
            //打印反转后的链表
            current = reversedList
            while let node = current {
                print(node.value)
                current = node.next
            }
        }
        
        //2.环形链表
        if hasCycle(node1) {
            print("环形链表")
        } else {
            print("不是环形链表")
        }

//        //3.合并两个有序链表
//        let list1 = Node(value: 1)
//        let list2 = Node(value: 2)
//        let list3 = Node(value: 3)
//        let list4 = Node(value: 4)
//        let list5 = Node(value: 5)
//        list1.next = list2
//        list2.next = list3  
//        list3.next = list4
//        list4.next = list5
//
//        if let mergedList = mergeTwoLists(list1: list1, list2: list2) {
//            //打印合并后的链表
//            current = mergedList
//            while let node = current {
//                print(node.value)
//                current = node.next
//            }
//        }   

        //6.找到view 的公共父视图
//        let view1 = UIView()
//        let view2 = UIView()
//        let view3 = UIView()
//        let view4 = UIView()
//        let view5 = UIView()
//        view1.addSubview(view2)
//        view2.addSubview(view3) 
//        view3.addSubview(view4)
//        view4.addSubview(view5)
//        view5.addSubview(view1)
//        view1.addSubview(view2)
//        view2.addSubview(view3) 
//        view3.addSubview(view4)
//        view4.addSubview(view5) 
//        if let commonView = findCommonSuperView(view1: view1, view2: view2) {
//            print("公共父视图: \(commonView)")
//        } else {
//            print("没有公共父视图")
//        }

        // 8.找到最长字符串不重复子串
        let longestSubstring = findLongestSubstring(s: "ajbcdefgaklo")
        print("最长字符串不重复子串: \(longestSubstring)")

//        // 9.字符串反转双指针 1
//        let reversedString = reverseString(s: "hello")
//        print("字符串反转: \(reversedString)")

        // 10.字符串反转栈
//        let reversedString2 = reverseString2(s: "hello")
//        print("字符串反转: \(reversedString2)")
//
//        let twoSumResult = twoSum(nums: [2, 7, 11, 15], target: 9)
//        print("两数之和: \(twoSumResult)")  

        // let coinChangeResult = coinChange(coins: [1, 2, 5], amount: 11)
        // print("凑零钱问题: \(coinChangeResult)")

//        var path: [String] = []
//        let choice: [String] = ["apple", "banana", "cherry"]
//        backTrack(path: &path, choice: choice)
//        print("组合结果: \(result)")
    }

    //1.反转链表
    func reveseList(head: Node?) -> Node? {
        var prev: Node? = nil
        var current: Node? = head
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        return prev
    }

    // 2.环形链表
    func hasCycle(_ head: Node?) -> Bool {
        var slow: Node? = head
        var fast: Node? = head?.next
        while fast != nil && fast?.next != nil {
            if slow === fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }

    //3.合并两个有序链表
    func mergeTwoLists(list1:Node?,list2:Node?) -> Node? {
        var dummy = Node(value: 0)
        var current = dummy
        var l1 = list1
        var l2 = list2
        while l1 != nil && l2 != nil {
            if l1!.value < l2!.value {
                current.next = l1
                l1 = l1?.next
            } else {
                current.next = l2
                l2 = l2?.next
            }
            current = current.next!
        }
        current.next = l1 ?? l2
        return dummy.next
    }

    //4.a b 两个值交换 不借助第三个变量
    func swapPairs(value1:Int,value2:Int) {
        var a = value1
        var b = value2
        a = a + b
        b = a - b
        a = a - b
        print("a: \(a), b: \(b)")
    }
    
    //用位运算
    func swapPairs2(value1:Int,value2:Int) {
        var a = value1
        var b = value2
        a = a ^ b
        b = a ^ b
        a = a ^ b
        print("a: \(a), b: \(b)")
    }

    //5.实现一个栈
    class Stack<T> {
        var items: [T] = []
        func push(_ item: T) {
            items.append(item)
        }
        func pop() -> T? {
            if items.isEmpty {
                return nil
            }
            let lastItem = items[items.count - 1]
            items.removeLast()
            return lastItem
        }
        func peek() -> T? {
            return items.last
        }
        func isEmpty() -> Bool {
            return items.isEmpty
        }
        func size() -> Int {
            return items.count
        }
        func clear() {
            items.removeAll()
        }
        func printStack() {
            print(items)
        }
    }

    //6.找到view 的公共父视图
    func findCommonSuperView(view1:UIView,view2:UIView) -> UIView? {
        var view1Superviews: [UIView] = []
        var view2Superviews: [UIView] = []
        
        var currentView = view1
        while let superview = currentView.superview {
            view1Superviews.append(superview)
            currentView = superview
        }
        
        currentView = view2
        while let superview = currentView.superview {
            view2Superviews.append(superview)
            currentView = superview
        }
        
        for view1Super in view1Superviews {
            for view2Super in view2Superviews {
                if view1Super === view2Super {
                    return view1Super
                }
            }
        }
        return nil
    }

//    //7.找到2叉树的公共父节点
//    func findCommonParentNode(node1:Node,node2:Node) -> Node? {
//        var node1Parents: [Node] = []
//        var node2Parents: [Node] = []
//        
//        var currentNode = node1
//        while let parent = currentNode.parent {
//            node1Parents.append(parent)
//            currentNode = parent
//        }
//        
//        currentNode = node2
//        while let parent = currentNode.parent {
//            node2Parents.append(parent)
//            currentNode = parent
//        }
//        
//        for node1Parent in node1Parents {
//            for node2Parent in node2Parents {
//                if node1Parent === node2Parent {
//                    return node1Parent
//                }
//            }
//        }
//        return nil
//    }
    
//    8.找到最长字符串不重复子串
    func findLongestSubstring(s:String) -> String {
        var maxLength = 0
        var maxSubstring = ""
        var charIndexMap: [Character: Int] = [:]
        
        var left = 0
        //左右滑动窗口
        for (right, char) in s.enumerated() {
            
            //字典判断是否重复出现
            let lastIndex = charIndexMap[char];
            if ((lastIndex) != nil) {
                //重复出现左侧右移一位（上次保存的左侧和当前对比 取最大）
                left = max(left, lastIndex! + 1);
            }
            
            //右侧减去左侧差值+1 因为索引是0开始
            let currentLength = right - left + 1;
            
            //更新最大长度
            if (currentLength > maxLength) {
                maxLength = currentLength;
                let startIndex = s.index(s.startIndex, offsetBy: left)
                let endIndex = s.index(s.startIndex, offsetBy: right + 1)
                
                maxSubstring = String(s[startIndex..<endIndex]);
            }
            
            //记录当前左侧位置
            charIndexMap[char] = left;
        }
        
        return maxSubstring
    }

    // 9.字符串反转双指针
    func reverseString(s:String) -> String {
        var chars = Array(s)
        var left = 0
        var right = chars.count - 1
        while left < right {
            let temp = chars[left]
            chars[left] = chars[right]
            chars[right] = temp
            left += 1
            right -= 1
        }
        return String(chars)
    }

    // 10.字符串反转栈
    func reverseString2(s:String) -> String {
        let stack = Stack<Any>()
        for char in s {
            stack.push(char)
        }
        var result = ""
        while !stack.isEmpty() {
            result += String(describing: stack.pop()!)
        }
        return result
    }
    //11.回文字符串
    func isPalindrome(s:String) -> Bool {
        let chars = Array(s)
        var left = 0
        var right = chars.count - 1
        while left < right {
            if chars[left] != chars[right] {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }   

    //12.有效括号匹配 
    func isValid(s:String) -> Bool {
        let stack = Stack<Character>()
        for char in s {
            if char == "(" || char == "[" || char == "{" {
                stack.push(char)
            } else {
                if stack.isEmpty() {
                    return false
                }
            }
            let top = stack.peek()
            if (char == ")" && top == "(") || (char == "]" && top == "[") || (char == "}" && top == "{") {
                stack.pop()
            } else {
                return false
            }
        }
        return stack.isEmpty()
    }

    //13.字符串中唯一的第一个不重复字符
    func firstUniqChar(s:String) -> Character? {
        // 使用数组记录字符出现顺序
        var charOrder: [Character] = []
        var charCount: [Character: Int] = [:]
        
        // 第一次遍历记录每个字符出现次数和顺序
        for char in s {
            if charCount[char] == nil {
                charOrder.append(char)
            }
            charCount[char, default: 0] += 1
        }
        
        // 按照字符出现顺序查找第一个只出现一次的字符
        for char in charOrder {
            if charCount[char] == 1 {
                return char
            }
        }
        return nil
    }

    //14.两数之和
//    let twoSumResult = twoSum(nums: [2, 7, 11, 15], target: 9)

    func twoSum(nums: [Int], target: Int) -> [Int] {
        var numDict: [Int: Int] = [:]
        for (index, num) in nums.enumerated() {
            let complement = target - num
            if let complementIndex = numDict[complement] {
                return [complementIndex, index]
            }
            numDict[num] = index
        }
        return []
    }

    //15.凑零钱问题
    //凑零钱问题思路:
    //1. 使用动态规划,dp[i]表示凑成金额i所需的最少硬币数
    //2. 初始化dp数组,dp[0]=0,其他位置初始化为amount+1(相当于无穷大)
    //3. 对于每个金额i,遍历每个硬币面值coin:
    //   - 如果coin <= i,说明可以使用这个硬币
    //   - dp[i] = min(dp[i], dp[i-coin] + 1)
    //   - dp[i-coin]表示金额i-coin所需的最少硬币数
    //   - +1表示使用当前这枚硬币
    //4. 最后如果dp[amount]>amount说明无法凑出,返回-1
    //   否则返回dp[amount]即为所需最少硬币数
    func coinChange(coins: [Int], amount: Int) -> Int {
        var dp = [Int](repeating: amount + 1, count: amount + 1)
        dp[0] = 0
        for i in 1...amount {
            for coin in coins {
                if coin <= i {
                    dp[i] = min(dp[i], dp[i - coin] + 1)
                }
            }
        }
    
        return dp[amount] > amount ? -1 : dp[amount]
    }
    
//    var result:Array = [];
    var result:[[String]] = []
    
    func backTrack(path:inout [String], choice:[String])  {
        if (path.count == 3) {
            result.append(path)
            return
        }
        
        for i in 0..<choice.count {
            let fruit = choice[i]
            
            path.append(fruit)
            
            var choiceArr = choice
            choiceArr.remove(at: i)
            
            backTrack(path: &path, choice: choiceArr)
            
            path.removeLast()
        }
    }
}
