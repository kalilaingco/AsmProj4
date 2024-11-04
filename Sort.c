// C program for implementation of selection sort
#include <stdio.h>

extern void Sort(long *arr, int size);

void Sort(long *arr, int size) {
    for (int i = 0; i < size - 1; i++) {
      
        // Assume the current position holds
        // the minimum element
        int min_idx = i;
        
        // Iterate through the unsorted portion
        // to find the actual minimum
        for (int j = i + 1; j < size; j++) {
            if (arr[j] < arr[min_idx]) {
              
                // Update min_idx if a smaller element is found
                min_idx = j;
            }
        }
        
        // Move minimum element to its
        // correct position
        long temp = arr[i];
        arr[i] = arr[min_idx];
        arr[min_idx] = temp;


    }
}