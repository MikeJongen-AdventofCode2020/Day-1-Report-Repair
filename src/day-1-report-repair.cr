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
  iter = values_str.each
  iter.each {|x| values_int << x.to_i}
end
