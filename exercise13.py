# Exercise 13 - Probability
# Edited by Tony Xiang
# Last Modified in 2018-7-17

import random

N = 45
total = 1000
MAX = 100000
group = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
prob = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
for i in range(1, total):
	r = random.randint(1, MAX)
	a = pow(N, r)
	b = str(a)
	c = int(b[0])
	group[c] += 1

for i in range(0, 10):
	prob[i] = group[i] / sum(group) 
print(prob) 