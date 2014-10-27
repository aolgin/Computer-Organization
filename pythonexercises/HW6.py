# Adam Olgin
# 11/18/13

# String-1

def without_end(str):
  return str[1:-1]

def extra_end(str):
  return str[-2:]+str[-2:]+str[-2:]

# String-2

def double_char(str):
  return ''.join([c+c for c in str])

def count_code(str):
  result = 0
  for i in range(len(str)-3):
      if str[i:i+2] == 'co' and str[i+3] == 'e':
         result += 1
  return result

def count_hi(str):
    return str.count('hi')

def end_other(a, b):
  a = a.lower()
  b = b.lower()
  return a.endswith(b) or b.endswith(a)

def cat_dog(str):
  return str.count('cat') == str.count('dog')

def xyz_there(str):
  return 'xyz' in str and str.count('xyz') > str.count('.xyz')

# List-1

def has23(nums):
  return 2 in nums or 3 in nums

def make_ends(nums):
  return [nums[0], nums[-1]]

def max_end3(nums):
  return 3*[max(nums[0], nums[-1])]

def rotate_left3(nums):
  return [nums[1], nums[2], nums[0]]

def sum3(nums):
  return sum(nums)

# List-2

def count_evens(nums):
  count = 0
  for i in range(len(nums)):
      if nums[i] % 2 == 0:
         count += 1
  return count

def sum13(nums):
  sum = 0
  int = 0
  while (int < len(nums)):
     if nums[int] == 13:
        int += 2
     else:   
        sum += nums[int]
        int += 1
  return sum

def big_diff(nums):
    return max(nums)-min(nums)

def centered_average(nums):
  big = max(nums)
  small = min(nums)
  total = sum(nums)-big-small
  return total/(len(nums)-2)

def has22(nums):
  result = False
  for i in range(len(nums)-1):
    if nums[i] == nums[i+1] == 2:
      result = True
  return result

def sum67(nums):
  sum = 0
  canAdd = 1
  for x in nums:
    if x == 6: 
      canAdd = 0
    sum += x*canAdd
    if x == 7: 
      canAdd = 1
  return sum


# HW2 Program 1
def wordCount(str):
  return [len(str.split('\n')), len(str.split()), len(str)]

# HW2 Program 2
def countOccurences(str):
  mycount = [ str.count(c) for c in "0123456789 \t\n" ]
  return mycount