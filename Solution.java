//LeetCode Question:
/*A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting 
* them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.
*
* The path sum of a path is the sum of the node's values in the path.
*
* Given the root of a binary tree, return the maximum path sum of any non-empty path.
* Example 1:
* Input: root = [1,2,3]
* Output: 6
* Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.
*/

//Notes: This java file does not contain main method. Please copy and paste the code of Solution class to LeetCode Problem 124.

class TreeNode {
	int val;
	TreeNode left;
	TreeNode right;
	TreeNode() {}
	TreeNode(int val) { this.val = val; }
	TreeNode(int val, TreeNode left, TreeNode right) {
		this.val = val;
		this.left = left;
		this.right = right;
	}
}

class Solution {
    //Store maximum value
	int maxval = Integer.MIN_VALUE;
    
	//Main Method
	public int maxPathSum(TreeNode root) {
        transverse(root);
        return maxval;
    }
    
	//Recursive function to transverse through the tree to find the maximum value in a path
    public int transverse(TreeNode root){
        //End the function if root is null
		if(root == null)return 0;
		
		//find the maximum value of a path in the left side of root
        int rightval = transverse(root.right);
		
		//find the maximum value of a path in the right side of root
        int leftval = transverse(root.left);
        
		//find the maximum value of a path under this root
		int reval = Math.max(root.val,Math.max(rightval + root.val,leftval + root.val));
		
		//find if the sum of left, right and current root value is larger than current maximum value;
		maxval = Math.max(maxval,Math.max(root.val,Math.max(rightval + root.val,leftval + root.val)));
        maxval = Math.max(maxval,rightval + leftval + root.val);
        return reval;
    }
}