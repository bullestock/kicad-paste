infile = ARGV[0]
if !infile
  puts "missing file"
  exit
end
inpath = false
style = nil
File.readlines(infile).each do |line|
  if inpath
    if line.include? '/>'
      inpath = false
    elsif line.include? 'd='
      pos = line.index 'd='
      parts = line[pos+2..].split(' ')
      if parts.size == 9
        puts '  <rect'
        puts style
        xy = parts[1].split(',')
        w = nil
        h = nil
        i = 2
        found_v = false
        found_h = false
        while i < parts.size
          p = parts[i]
          if p == 'v'
            found_v = true
          elsif p == 'h'
            found_h = true
          elsif found_v
            h = p.to_i
            found_v = false
          elsif found_h
            w = p.to_i
            found_h = false
          end
          if w && h
            break
          end
          i = i + 1
        end
        x = xy[0].to_i
        y = xy[1].to_i
        if w < 0
          x = x + w
        end
        if h < 0
          y = y + h
        end
        rr=500000
        puts "     x=\"#{x}\" y=\"#{y}\" width=\"#{w.abs()}\" height=\"#{h.abs()}\" rx=\"#{rr}\" ry=\"#{rr}\""
      else
        # complex path
        puts '<path'
        puts style
        puts line
      end
    else
      #puts line
    end
  end
  if line.include? '<path'
    inpath = true
  end
  if inpath
    if line.include? 'style'
      style = line
    end
  else
    puts line
  end
end
