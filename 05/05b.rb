#!/usr/bin/ruby

text = STDIN.read

linepat = /(\d+),(\d+) -> (\d+),(\d+)\n/
store = {}  # sparse array
while m = linepat.match(text)
   text = m.post_match
   # p m[0]
   x1,y1,x2,y2 = [m[1],m[2],m[3],m[4]].map &:to_i
   if (x1 == x2) # vertical line
      for y in [y1,y2].min..[y1,y2].max
         store[[x1,y]] = if store[[x1,y]] then store[[x1,y]] + 1 else 1 end
      end
   elsif (y1 == y2)
      for x in [x1,x2].min..[x1,x2].max
         store[[x,y1]] = if store[[x,y1]] then store[[x,y1]] + 1 else 1 end
      end
   elsif ((x1-x2) == (y1-y2))
     y = [y1,y2].min
     for x in [x1,x2].min..[x1,x2].max
         store[[x,y]] = if store[[x,y]] then store[[x,y]] + 1 else 1 end
         y = y + 1
     end
   elsif ((x1-x2) == -(y1-y2))
      y = [y1,y2].max
      for x in [x1,x2].min..[x1,x2].max
          store[[x,y]] = if store[[x,y]] then store[[x,y]] + 1 else 1 end
          y = y - 1
      end
   end
end
# p store
tot = 0
store.each {|k,v| tot += 1 if v > 1}
p tot














#endoffile
