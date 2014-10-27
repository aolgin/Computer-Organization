// hw5.c
// Adam Olgin

#include <stdio.h>

struct cacheLine { 
  int valid; 
  int tag;
  int counter;
  struct cacheLine *next;
};

struct cacheLine cache[5000];

/**
 READ BEFORE RUNNING:
 These fields must be manually set
 to meet the test conditions. Descriptions
 are given next to them.
 The offset in main must also be inputed manually.

 For a Direct-Mapped Cache, set k = 1
 */
int cacheSize = 64; // in bytes
int blockSize = 8; // in bytes
int numCacheLines = 8; // (cacheSize/blockSize)
int k = 2; // linesPerSet

// the test set
int test_set_1[] = { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 
                     52, 56, 60, 64, 68, 72, 76, 80, 0, 4, 8, 12, 16, 
                     71, 3, 41, 81, 39, 38, 71, 15, 39, 11, 51, 57, 41 };
int setSize = 39; // the number of elements in the set

// run the emulator on the test set
int main(int argc, char * argv[]) {
    int offset = 3; // number of offset bits (log2(blockSize))
    int numSets = numCacheLines / k; // (numCacheLines / k)

    // print the header
    printf("Address\tTagSet\tTag\tSet\tHit/Miss\n");
    // I think that statement is correct (the for conditions)
    int i;
    for (i = 0; i < setSize; i++) {
      int tagFromSet = test_set_1[i];  // get the current tag from the test set
      int tagSet = tagFromSet >> offset; // calculate the tagSet

      int tag = tagSet / numSets; // calculate the tag (TAG, set)
      
      int setNum = tagSet % numSets; // calculate the set number (tag, SET)

      // We declared isHitOrMiss above.  But we define it below.
      int answer = isHitOrMiss(k, tag, setNum);

      if (answer)
        printf("%d\t%d\t%d\t%d\tHit\n", tagFromSet, tagSet, tag, setNum);
      else
        printf("%d\t%d\t%d\t%d\tMiss\n", tagFromSet, tagSet, tag, setNum);
    }
    return 0;  // The fnc main returns 0 for success.  Anything else is error number.
}

// is this a hit or a miss?
// perform the rewrite/eviction if a miss
int findOldest(int start, int end);
int isHitOrMiss(int k, int tag, int index) {
    int isHit = 0;  // Initialize isHit to default value:  false
    int rowIdx = 0;  // Initialize the row index to 0
    
    // For set associative, index is the set number.
    for (rowIdx = k*index; rowIdx < k*index + k; rowIdx++)
      if (cache[rowIdx].valid && cache[rowIdx].tag == tag) {
        isHit = 1;
        break;
      }

    // Now, isHit has value true if and only if we found a hit.
    if (isHit) return 1; // return true
    
    // Else search for cache line with valid field == 0 (false)
    for (rowIdx = k*index; rowIdx < k*index + k; rowIdx++) {
      if (cache[rowIdx].valid == 0)
        cache[rowIdx].valid = 1; // make it valid
        cache[rowIdx].tag = tag; // write in the new tag
        cache[rowIdx].counter = rowIdx;
        break;
      }

    // If we didn't find a cache line with valid field false, then evict cache line
    if (rowIdx + k >= k * index) { // if falied to find invalid cache line
      int eldest = findOldest(rowIdx, rowIdx + k);
      cache[eldest].tag = tag; // overwrite the old tag
      cache[eldest].counter = (rowIdx+k)+1; // reset the counter      
    }
    return isHit;
}

// calculate the number of bits in the offset
int calcOffsetBits() {
  int i;
  int power = 1;
  for (i = 0; power <= blockSize; i++) {
    power = 2 * power;
  }
  return power;
}

// start is the first of the set, end is the end of the set
// find the index of the oldest added tag row in the set
int findOldest(int start, int end) {
    int minIdx;
    int i;
    for (i = start; i < end; i++) {
      if (cache[i].counter < cache[i+1].counter)
        minIdx = i;
      else
        minIdx = i+1;
      break;
    }
    return minIdx;
}