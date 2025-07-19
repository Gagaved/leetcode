import 'dart:math' as math;

class Solution {
  int longestSubarray(List<int> nums) {
    int last = 0;
    int previous = 0;
    int max = 0;
    for (int i = 0; i < nums.length; i++) {
      if (nums[i] == 0) {
        max = math.max(previous + last, max);
        previous = last;
        last = 0;
      } else {
        if (i == nums.length - 1) {
          last += 1;
          max = math.max(previous + last, max);
          break;
        }
        last += 1;
      }
    }
    return math.min(max, nums.length - 1);
  }
}

void main() {
  final result = Solution().longestSubarray([1, 1, 1]);
  print(result);
  final result2 = Solution().longestSubarray([0, 1, 1]);
  print(result2);
  final result3 = Solution().longestSubarray([1, 1, 0]);
  print(result3);
}

// Example 1:
//
// Input: nums = [1,1,0,1]
// Output: 3
// Explanation: After deleting the number in position 2, [1,1,1] contains 3 numbers with value of 1's.
// Example 2:
//
// Input: nums = [0,1,1,1,0,1,1,0,1]
// Output: 5
// Explanation: After deleting the number in position 4, [0,1,1,1,1,1,0,1] longest subarray with value of 1's is [1,1,1,1,1].
// Example 3:
//
// Input: nums = [1,1,1]
// Output: 2
// Explanation: You must delete one element.
