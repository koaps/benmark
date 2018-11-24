#!/usr/bin/env ruby

require 'gnuplot'

(p "Files to parse not specified";exit) if ARGV[0].nil?

# Class instance is created for each file passed to script
class FCount
  attr_accessor :cvals, :fname

  def initialize
    @cvals = {}
  end

  def cdel(k)
    @cvals.delete(k)
  end

  # Count number of requests at a particular time
  def countme(num)
    num = num.to_i
    if @cvals[num].nil?
      @cvals[num] = 1
    else
      @cvals[num] = @cvals[num] + 1
    end
  end

  # File Loader
  def fload(f)
    File.open(f).each do |line|
      fi=0
      next if line =~ /time/
      line.split("\t").each do |field|
        fi += 1
        if fi == 5; self.countme(field) else next end
      end
    end
  end

end

$Files = []
ARGV.each do |f|
  fc = FCount.new
  ##
  ##===> Change the extension if needed
  ##
  fc.fname = (File.basename(f, '.tsv'))
  fc.fload(f)
  $Files.push fc
end

#
# Filter - Cut off requests taking longer than this, helps to scale the graph.
#
cutoff = 500
#### This block can be commented out to disable cutoff
#=begin
$Files.each do |f|
  f.cvals.each do |c|
      f.cdel(c[0]) if c[0] > cutoff
  end
end
#=end

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|

    plot.terminal "png size 800,600"
    ##
    ##===>  Set the path
    ##
    plot.output "/home/test/#{ARGV[0]}.png"

    plot.title "Number of the requests served within a certain time (ms)"
    plot.ylabel "Requests"
    plot.xlabel "Time (ms)"
    plot.grid "xtics ytics"

    $Files.each do |f|
      x = f.cvals.keys.collect { |k| k.to_f }
      y = f.cvals.values
      plot.data << Gnuplot::DataSet.new( [x,y] ) do |ds|
        ds.with = "lines"
        ds.title = f.fname
      end
    end
  end
end
