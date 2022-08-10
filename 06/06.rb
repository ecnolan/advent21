#!/usr/bin/ruby

text = STDIN.read

agepat = /\d/
today = {}  # sparse array
yesterday = {}
for n in 0..8
  today[n] = 0
end

while m = agepat.match(text)
   text = m.post_match
   age = m[0].to_i
   today[age] = if today[age] then today[age] + 1 else 1 end
end



p today

days = 256

for day in 0..days
  for d in 0..8
    yesterday[d] = today[d]
  end
  for n in 0..8
    if n == 6
      today[n] = yesterday[7] + yesterday[0]
    elsif n == 8
      today[n] = yesterday[0]
    else
      today[n] = if yesterday[n+1] then yesterday[n+1] end
    end
  end
  # p yesterday
  # p today
  tot = 0
  for n in 0..8
    tot = tot + yesterday[n]
  end
  puts "#{day}: #{tot}"
end

tot = 0
for n in 0..8
  tot = tot + yesterday[n]
end
p tot
