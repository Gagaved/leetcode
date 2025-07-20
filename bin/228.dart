import 'dart:math';

class Solution {
  List<String> summaryRanges(List<int> nums) {
    nums.add(pow(2, 32).toInt());
    final result = <String>[];
    int? currentRangeStartIndex;
    for (int i = 0; i < nums.length; i++) {
      if (currentRangeStartIndex == null) {
        currentRangeStartIndex = i;
      } else if (nums[i] - nums[i - 1] != 1) {
        if (i - currentRangeStartIndex == 1) {
          result.add('${nums[currentRangeStartIndex]}');
        } else {
          result.add('${nums[currentRangeStartIndex]}->${nums[i - 1]}');
        }
        currentRangeStartIndex = i;
      }
    }
    return result;
  }
}

void main() {
  final result = Solution().summaryRanges([0, 2, 3, 4, 6, 8, 9]);
  print(result);
}
