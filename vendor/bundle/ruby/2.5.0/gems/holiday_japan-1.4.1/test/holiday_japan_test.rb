require "test/unit"
require "holiday_japan"
require "csv"

$first_year = 1948
$last_year = 2019
$range = $first_year..$last_year
$csv_file = File.join(__dir__,"holiday.csv")

# write CSV data and exit
case ARGV[0]
when /^w/i
  CSV.open($csv_file,"w"){|c| HolidayJapan.between($first_year,$last_year).each{|a| c<<a}}
  exit
end

$csv = CSV.open(File.join(__dir__,"holiday.csv"),"r")
$hash = {}
$list = []

$range.each do |y|
  $hash[y] = {}
end

$csv.each do |str,name|
  date = Date.parse(str)
  $hash[date.year][date] = name
  $list << [date,name]
end

class HolidayJapanTest < Test::Unit::TestCase

  test "name" do
    $list.each do |date,name|
      assert{ HolidayJapan.name(date) == name }
    end
  end

  test "hash_year" do
    $range.each do |year|
      assert{ HolidayJapan.hash_year(year) == $hash[year] }
    end
  end

  test "list_year" do
    $range.each do |year|
      HolidayJapan.list_year(year).each do |date,name|
        assert{ $hash[year][date] == name }
      end
    end
  end

end
