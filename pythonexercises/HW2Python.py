# Adam Olgin
# 11/18/13

# HW2 Program 1
def wordCount(str):
	return [len(str.split('\n')), len(str.split()), len(str)]

# HW2 Program 2
def countOccurences(str):
  mycount = [ str.count(c) for c in "0123456789 \t\n" ]
  return mycount