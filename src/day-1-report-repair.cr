require "option_parser"
require "benchmark"

file_name = ""
triple = false
benchmark = false
result = 0

OptionParser.parse do |parser|
  parser.banner = "Welcome to Report Repair"

  parser.on "-f FILE", "--file=FILE", "Input file" do |file|
    file_name = file
  end
  parser.on "-t", "--three", "Use three Numbers" do
    triple = true
  end
  parser.on "-b", "--benchmark", "Measure benchmarks" do
    benchmark = true
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
  
  if triple
    if benchmark
      Benchmark.ips do |x|
        x.report("triple") {result = product_3_if_sum_equals(values_int)}
      end
    else
      result = product_3_if_sum_equals(values_int)
    end
  else
    if benchmark
      Benchmark.ips do |x|
        x.report("double") {result = product_2_if_sum_equals(values_int)}
      end
    else
      result = product_2_if_sum_equals(values_int)
    end
  end

  puts result
end

def product_2_if_sum_equals(values : Array(Int32))
  index = 0

  values[0,values.size].each do |y|
    values[index,values.size].each do |x|
      if (y + x) == 2020
        return y * x
      end
    end
    index += 1
  end
end

def product_3_if_sum_equals(values : Array(Int32))
  index = 0
  index2 = 0

  values[0,values.size].each do |y|
    values[index,values.size].each do |x|
      values[index2,values.size].each do |z|
        if (y + x + z) == 2020
          return y * x * z
        end
      end
    end
    index += 1
  end
end
