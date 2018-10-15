# login inputtag
module SessionsHelper
  def input_email
    content_string = ''.html_safe
    content_tag(:div, class:'main item') do
      content_string << 'emain'
      content_string << email_field(:user,:email)
    end
  end

  def input_password
    content_string = ''.html_safe
     content_tag(:div, class:'main item') do
      content_string << 'password'
      content_string << password_field(:user,:password)
    end
  end

  def show_message
    if @error_message
      content_tag(:div, class:'error_message') do
        @error_message
      end
    end
  end
end
