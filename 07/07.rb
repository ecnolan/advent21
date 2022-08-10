#!/usr/bin/ruby

def dist(x,t)
  d = x - t
  s = d * d
  d = Math.sqrt((x - t)*(x - t))
  cost = 0
  for step in 0..d
    cost = cost + step
  end
  return cost
end

def totaldist(list,t)
  sum = 0
  for num in list
    sum = sum + dist(num, t)
  end
  return sum
end

def avg(list)
  counter = 0
  sum = 0
  for item in list
    counter = counter + 1
    sum = sum + item
    # puts "counter: #{counter}, sum: #{sum}"
  end
  # puts (sum/counter)
  return (sum / counter)

end

data = STDIN.read
pat = /(\d+)/

# save positions in pos list
pos = []
while pat.match(data)
  d = pat.match(data)
  pos << d[0].to_i
  data = d.post_match
end
# puts pos.inspect

# dist:
# for t in 0...14
  # puts "#{totaldist(pos, t)}"
# end

av = avg(pos)
avt = totaldist(pos, av)
ap1t = totaldist(pos, av + 1)
# puts avt
# puts ap1t

if avt < ap1t
  inc = -1
else inc = 1 end

puts inc
puts totaldist(pos, 5)

decreasing = true
min = avt
loc = av
while (decreasing == true)
  newmin = totaldist(pos, loc)
  # puts "newmin: #{newmin}, oldmin = #{min}"
  if newmin <= min
    min = newmin
  else
    decreasing = false
    puts "#{min} at position #{loc - inc}"
    # break
  end
  loc = loc + inc
end





# goal:
# get average
# see if average +1 or average - 1 is larger
