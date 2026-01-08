#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 链表节点
@interface Node : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong, nullable) Node *next;
@property (nonatomic, strong, nullable) Node *pre;

- (instancetype)initWithValue:(NSInteger)value;

@end

// 栈
@interface Stack : NSObject

- (void)push:(id)item;
- (nullable id)pop;
- (nullable id)peek;
- (BOOL)isEmpty;
- (NSInteger)size;
- (void)clear;
- (void)printStack;

@end

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong, nullable) TreeNode *left;
@property (nonatomic, strong, nullable) TreeNode *right;

@end

@interface ArithmeticLearnOC : UIViewController
+ (void)longSubList:(NSArray *)originArr;
@end

NS_ASSUME_NONNULL_END
