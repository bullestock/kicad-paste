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
        puts '<rect'
        puts style
        xy = parts[1].split(',')
        puts "     x=\"#{xy[0]}\" y=\"#{xy[1]}\" width=\"#{parts[3].to_i.abs()}\" height=\"#{parts[5]}\""
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
