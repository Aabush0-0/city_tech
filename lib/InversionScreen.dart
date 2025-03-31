import 'package:flutter/material.dart';

class InversionScreen extends StatelessWidget {
  const InversionScreen({super.key});

  int countInversions(List<int> arr) {
    List<int> tempArr = List<int>.filled(arr.length, 0);
    return mergeAndCount(arr, tempArr, 0, arr.length - 1);
  }

  int mergeAndCount(List<int> arr, List<int> tempArr, int left, int right) {
    int invCount = 0;
    if (left < right) {
      int mid = (left + right) ~/ 2;

      invCount += mergeAndCount(arr, tempArr, left, mid);
      invCount += mergeAndCount(arr, tempArr, mid + 1, right);

      invCount += merge(arr, tempArr, left, mid, right);
    }
    return invCount;
  }

  int merge(List<int> arr, List<int> tempArr, int left, int mid, int right) {
    int i = left, j = mid + 1, k = left;
    int invCount = 0;

    while (i <= mid && j <= right) {
      if (arr[i] <= arr[j]) {
        tempArr[k++] = arr[i++];
      } else {
        tempArr[k++] = arr[j++];
        invCount += (mid - i + 1);
      }
    }

    while (i <= mid) {
      tempArr[k++] = arr[i++];
    }

    while (j <= right) {
      tempArr[k++] = arr[j++];
    }

    for (int i = left; i <= right; i++) {
      arr[i] = tempArr[i];
    }

    return invCount;
  }

  @override
  Widget build(BuildContext context) {
    List<int> arr = [1, 20, 6, 4, 5];

    return Scaffold(
      appBar: AppBar(title: Text('Flutter Inversion Counter')),
      body: Center(
        child: Text(
          'Total inversions: ${countInversions(arr)}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
