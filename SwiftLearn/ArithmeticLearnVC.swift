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
        if let reversedList = reveseList(node1) {
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
    }

    //1.反转链表
    func reveseList(_ head: Node?) -> Node? {
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
    class Stack {
        var items: [Int] = []
        func push(_ item: Int) {
            items.append(item)
        }
        func pop() -> Int? {
            if items.isEmpty {
                return nil
            }
            let lastItem = items[items.count - 1]
            items.removeLast()
            return lastItem
        }
        func peek() -> Int? {
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
}
