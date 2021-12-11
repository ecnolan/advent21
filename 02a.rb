#!/usr/bin/ruby

data = STDIN.read

dpat = /(\w+) (\d+)\n/

depth = 0
pos = 0
aim = 0

while (data != "")
  dm = dpat.match(data)
  puts dm
  dir = dm[1]
  a = dm[2].to_i

  if dir[0] == "f"
    pos = pos + a
    depth = depth + (aim * a)
  elsif dir[0] == "u"
    aim = aim - a
  else
    # down
    aim = aim + a
  end
  puts "pos #{pos}, aim #{aim}, depth #{depth}"
  data = dm.post_match
end

puts depth * pos
