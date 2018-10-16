module UsersHelper

  def pulldown_year
    (@today.year.to_i - 10..@today.year.to_i + 10).map{|i| @show_years << i}
    select_tag('select_year',
      options_for_select(@show_years,
                        class: 'opt_year',
                        selected: @today.year.to_i, 
                        ),
      :onchange => 'users/show') + '年'
  end

  def pulldown_month
    select_tag('select_month',
      options_for_select((1..12),
                        class:'opt_month',
                        selected: @today.month.to_i),
      :onchange => 'users/show') + '月'
  end

  #ボタンの表示
  def attendance_button
    content_tag(:div , class: 'search-rightend') do
      content_tag(:div, class: 'inputtime') do
        button_tag('出勤', name: 'syukkin' ) +
        button_tag('退勤', name: 'taikin') +
        form_with(url: "/users/save", local: true, class: 'save-button') do
          content_tag(:div, class: 'attend-save') do
            button_tag('保存', name: 'attend_save')
          end
        end
      end
    end
  end

  #テーブルヘッダー
  def table_header
    content_tag(:tr) do
      content_tag(:th,'日付') +
      content_tag(:th,'曜日') +
      content_tag(:th,'出勤時間')+ 
      content_tag(:th,'退勤時間')+
      content_tag(:th,'状況')
    end
  end

  def table_rows
    content_string =''.html_safe
    (1..@lastday).each do |row|
      content_string << table_row(row)
    end
    content_string
  end

  def table_row(row)
    @dateofweek = ["日","月","火","水","木","金","土"]
    content_tag(:tr, row, name: "row_#{row}") do
      # 日付
      content_tag(:th, row, name: "date_#{row}")+
      # 曜日
      content_tag(:th, @dateofweek[@today.change(day: row ).wday],
       name:"rowofweek_#{@today.change(day: row ).wday}") +
      # 出勤時間
      content_tag(:th,name:"start_work_#{row}" ) do
        time_select("work_#{row}", 'start',
        :default => {:hour => '10', :minute => '00'})
      end +
      # 退勤時間
      content_tag(:th, name:"end_work_#{row}") do
        time_select("work_#{row}",'end',
        :default => {:hour => '19', :minute => '00'})
      end+
      # 状況
      content_tag(:th) do
        select_tag("status_#{row}",
          options_for_select(['出勤','有給休暇','午前休暇','午後休暇','休日出勤','欠勤']))
      end
    end
  end

  def table_name_date(value)
    "date_#{value}"
  end
end
