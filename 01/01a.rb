#!/usr/bin/ruby

data = STDIN.read

numspat = /(\d+)\n/
mnums = numspat.match(data)
numbers = []
while (data != "")
  m = numspat.match(data)
  if m
    numbers << m[1].to_i
    data = m.post_match
  else
    data = ""
  end
end

tot = 0
for i in 1..(numbers.length()-1)
  if numbers[i] > numbers[i-1]
    tot = tot + 1
  end
end
# answer a
p tot
puts " "


# part b
sums = []
tot = 0
for i in 0..(numbers.length()-3)
  sum = numbers[i] + numbers[i+1] + numbers[i+2]
  sums << sum
end

tot = 0
for i in 1..(sums.length()-1)
  if sums[i] > sums[i-1]
    tot = tot + 1
  end
end
# answer b
p tot
