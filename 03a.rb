#!/usr/bin/ruby

data = STDIN.read
gam = 0
eps = 0
pow = gam * eps

# save binary numbers to list as strings
bpat = /(\d*)\n/
allbins = []
digits = bpat.match(data)[1].length()
while data != ""
  bin = bpat.match(data)
  allbins << bin[1]
  data = bin.post_match
end

def getgam(allbins)
  digits = allbins[0].length
  gammadigs = ""
  epsilondigs = ""
  for i in 0..(digits - 1)
    ones = 0
    zeroes = 0
    for binum in allbins
      ones = ones + binum[i].to_i
    end
    # add majority digit to string for gamma, minority for epsilon
    zeroes = allbins.length() - ones
    # puts "digit #{i}: #{zeroes} zeros, #{ones} ones"
    if (ones >= zeroes)
      epsilondigs = epsilondigs + "0"
      gammadigs = gammadigs + "1"
    else
      epsilondigs = epsilondigs + "1"
      gammadigs = gammadigs + "0"
    end
  end
  return [gammadigs, epsilondigs]
end


gammadigs, epsilondigs = getgam(allbins)
# get gamma and epsilon score
# gammadigs = ""
# epsilondigs = ""
# for i in 0..(digits - 1)
#   gsum = 0
#   for binum in allbins
#     gsum = gsum + binum[i].to_i
#   end
#   # add majority digit to string for gamma, minority for epsilon
#   epsilondigs = epsilondigs + (allbins.length/gsum - 1).to_s
#   gammadigs = gammadigs + (-(allbins.length/gsum - 2)).to_s
# end



# power score

puts gammadigs.to_i(2) * epsilondigs.to_i(2)
puts "gamma: #{gammadigs}"

# part b:

# lsr = ogr * csr
# start w scores:
# puts allbins.inspect

i = 0
ogr = []
ogrnew = []
csr = []
csrnew = []

for item in allbins
  ogr << item
  csr << item
end

for i in 0..(digits-1)
  j = 0
  # puts "digit #{i}"
  # puts ogr.inspect
  currbest = getgam(ogr)[0]
  # puts currbest


  while (ogr.length() > 1) and (j < ogr.length())
    if ogr[j][i] != currbest[i]
      ogr.delete_at(j)
    else j = j + 1
    end
  end
end
puts ogr.inspect

for i in 0..(digits-1)
  j = 0
  # puts "digit #{i}"
  # puts csr.inspect
  currbest = getgam(csr)[0]
  # puts currbest

  while (csr.length() > 1) and (j < ogr.length())
    if csr[j][i] = currbest[i]
      csr.delete_at(j)
    else j = j + 1
    end
  end
end
puts csr.inspect

puts ogr[0]
puts csr[0]

puts ogr[0].to_i(2) * csr[0].to_i(2)
