# -*- coding: utf-8 -*-
# (C) Copyright 2003-2017 by Masahiro TANAKA
# This program is free software under MIT license.
# NO WARRANTY.
require "date"

module HolidayJapan

  VERSION = "1.4.1"

  WEEK1 =  1
  WEEK2 =  8
  WEEK3 = 15
  WEEK4 = 22
  SUN,MON,TUE,WED,THU,FRU,SAT = (0..6).to_a
  INF = (defined? Float::INFINITY) ? Float::INFINITY : 1e16

  # 祝日データ: 1948年7月20日以降で有効
  DATA = [
    ["元日",        [1949..INF ,  1,   1 ]],
    ["成人の日",    [2000..INF ,  1, [WEEK2,MON]],
                    [1949..1999,  1,  15 ]],
    ["建国記念の日",[1967..INF ,  2,  11 ]],
    ["昭和の日",    [2007..INF ,  4,  29 ]],
    ["憲法記念日",  [1949..INF ,  5,   3 ]],
    ["みどりの日",  [2007..INF ,  5,   4 ],
                    [1989..2006,  4,  29 ]],
    ["こどもの日",  [1949..INF ,  5,   5 ]],
    ["海の日",      [2020,        7,  23 ],
                    [2003..INF,  7, [WEEK3,MON]],
                    [1996..2002,  7,  20 ]],
    ["山の日",      [2020,        8,  10 ],
                    [2016..INF ,  8,  11 ]],
    ["敬老の日",    [2003..INF ,  9, [WEEK3,MON]],
                    [1966..2002,  9,  15 ]],
    ["体育の日",    [2000..2019, 10, [WEEK2,MON]],
                    [1966..1999, 10,  10 ]],
    ["スポーツの日",[2020,        7,  24 ],
                    [2021..INF , 10, [WEEK2,MON]]],
    ["文化の日",    [1948..INF , 11,   3 ]],
    ["勤労感謝の日",[1948..INF , 11,  23 ]],
    ["天皇誕生日",  [2020..INF ,  2,  23 ],
                    [1989..2018, 12,  23 ],
                    [1949..1988,  4,  29 ]],
    ["春分の日",
     [1980..2099,  3, proc{|y|(20.8431+0.242194*(y-1980)).to_i-((y-1980)/4.0).to_i} ],
     [1949..1979,  3, proc{|y|(20.8357+0.242194*(y-1980)).to_i-((y-1983)/4.0).to_i} ],
     [2100..2150,  3, proc{|y|(21.8510+0.242194*(y-1980)).to_i-((y-1980)/4.0).to_i} ],
    ],
    ["秋分の日" ,
     [1980..2099,  9, proc{|y|(23.2488+0.242194*(y-1980)).to_i-((y-1980)/4.0).to_i} ],
     [1948..1979,  9, proc{|y|(23.2588+0.242194*(y-1980)).to_i-((y-1983)/4.0).to_i} ],
     [2100..2150,  9, proc{|y|(24.2488+0.242194*(y-1980)).to_i-((y-1980)/4.0).to_i} ],
    ],
    ["皇太子明仁親王の結婚の儀",  [1959,  4, 10 ]],
    ["昭和天皇の大喪の礼",        [1989,  2, 24 ]],
    ["即位礼正殿の儀",            [1990, 11, 12 ]],
    ["皇太子徳仁親王の結婚の儀",  [1993,  6,  9 ]],
  ]
  DATA.each{|x| x.each{|y| y .freeze}}
  DATA.freeze
  TABLE = {}
  FURIKAE_START = Date.new(1973,4,12).freeze

  module_function

  def holiday_date(year,data)
    data.each do |item|
      next if item.kind_of?(String)
      year_range,mon,day = *item
      if year_range === year
        case day
        when Integer
          # skip
        when Array
          day0,wday = day
          wday0 = Date.new(year,mon,day0).wday
          day = day0+(wday-wday0+7)%7
        when Proc
          day = day.call(year)
        else
          raise "invalid holiday data"
        end
        return Date.new( year, mon, day )
      end
    end
    nil
  end

  def create_table(y)
    h={}
    a=[]
    # list holidays
    DATA.each do |x|
      if d = holiday_date(y,x)
        h[d] = x[0]
        a << d
      end
    end
    # compensating holiday
    if y >= 2007
      a.each do |d|
        if d.wday==SUN
          d+=1 while h[d]
          h[d] = "振替休日"
        end
      end
    elsif y >= 1973
      a.each do |d|
        if d.wday==SUN and d>=FURIKAE_START
          h[d+1] = "振替休日"
        end
      end
    end
    # consecutive holiday
    if y >= 1986
      a.each do |d|
        if h[d+2] and !h[d+1] and d.wday!=SAT
          h[d+1] = "国民の休日"
        end
      end
    end
    Hash[h.sort_by{|d,| d}].freeze
  end

  def name(date)
    y = date.year
    (TABLE[y] ||= create_table(y))[date]
  end

  def check(date)
    !HolidayJapan.name(date).nil?
  end

  def list_year(year)
    year = Integer(year)
    TABLE[year] ||= create_table(year)
    TABLE[year].sort_by{|x| x[0]}
  end

  def hash_year(year)
    TABLE[year] ||= create_table(year)
  end

  def between(from_date,to_date)
    case from_date
    when String
      from_date = Date.parse(from_date)
    when Integer
      from_date = Date.new(from_date,1,1)
    when Date
    else
      raise ArgumentError, "invalid type fpr from_date"
    end
    case to_date
    when String
      to_date = Date.parse(to_date)
    when Integer
      to_date = Date.new(to_date,12,31)
    when Date
    else
      raise ArgumentError, "invalid type fpr to_date"
    end
    if from_date > to_date
      raise ArgumentError, "to_date is earlier than from_date"
    end
    y1 = from_date.year
    y2 = to_date.year
    if y1 == y2
      result = hash_year(y1).select{|d,n| d >= from_date && d <= to_date}
    else
      result = hash_year(y1).select{|d,n| d >= from_date}
      y = y1 + 1
      while y < y2
        result.merge!(hash_year(y))
        y += 1
      end
      hash_year(y).each{|d,n| result[d]=n if d <= to_date}
    end
    result
  end

  def _print_year(year)
    puts "listing year #{year}..."
    list_year(year).each do |y|
      puts "#{y[0].strftime('%Y-%m-%d %a')} #{y[1]}"
    end
  end

  def print_year(year)
    case year
    when Range
      year.each do |y|
        _print_year(y)
      end
    else
      _print_year(year)
    end
  end

  def print_between(from_date,to_date)
    between(from_date,to_date).each do |y|
      puts "#{y[0].strftime('%Y-%m-%d %a')} #{y[1]}"
    end
  end
end


# compatible with Funaba-san's holiday.rb
class Date
  def national_holiday?
    HolidayJapan.name(self) ? true : false
  end
end

# command line
if __FILE__ == $0
  # print holiday list of the year
  begin
    arg = eval(ARGV[0])
  rescue
    raise ArgumentError,"invalid argument : #{ARGV[0].inspect}
 usage:
    ruby holiday_japan.rb year"
  end
  HolidayJapan.print_year(arg)
end
