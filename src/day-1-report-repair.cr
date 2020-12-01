require "option_parser"

file_name = ""

OptionParser.parse do |parser|
  parser.banner = "Welcome to Report Repair"

  parser.on "-f FILE", "--file=FILE", "Input file" do |file|
    file_name = file
  end
  parser.on "-h", "--help", "Show help" do
    puts parser
    exit
  end
end

unless file_name.empty?
  values_str = File.read_lines(file_name)
  values_int = Array(Int32).new
  values_str.each {|x| values_int << x.to_i}
  
  index = 0
  values_int[0,values_str.size].each do |y|
    values_int[index,values_str.size].each do |x|
      if (y + x) == 2020
        puts y * x
      end
    end
    index += 1
  end
end
