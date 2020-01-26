import UIKit

open class TreeNode<T: Comparable> {
    fileprivate var value: T
    fileprivate var parent: TreeNode?
    fileprivate var left: TreeNode?
    fileprivate var right: TreeNode?
    
    public init(value: T, parent: TreeNode? = nil, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.parent = parent
        self.left = left
        self.right = right
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasSingleLeftChild: Bool {
        return left != nil && right == nil
    }
    
    public var hasSingleRightChild: Bool {
        return left == nil && right != nil
    }
    
    public var hasAnyChild: Bool {
        return left != nil || right != nil
    }
    
    public var hasBothChild: Bool {
        return left != nil && right != nil
    }
    

open class BST<T: Comparable> {
    fileprivate(set) public var root: TreeNode<T>?
    
    public init(_ value: T) {
        self.root = TreeNode<T>(value: value)
    }
    
    public init(_ array: [T]) {
        precondition(array.count > 0)
        
        self.root = TreeNode<T>(value: array[0])
        
        for value in array[1 ..< array.count] {
            insert(value: value)
        }
    }
    
    open func insert(value: T) {
        self.insert(value: value, under: self.root!)
    }
}

extension BST {
    fileprivate func insert(value: T, under parent: TreeNode<T>) {
        if value < parent.value {
            if let left = parent.left {
                insert(value: value, under: left)
            } else {
                let node = TreeNode<T>(value: value)
                parent.left = node
                node.parent = parent
            }
        } else if value > parent.value {
            if let right = parent.right {
                insert(value: value, under: right)
            } else {
                let node = TreeNode<T>(value: value)
                parent.right = node
                node.parent = parent
            }
        }
    }
}
