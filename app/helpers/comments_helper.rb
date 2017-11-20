module CommentsHelper
  def choose_show_or_edit
binding.pry
    if action_name == 'show'
      confirm_comment_path
    elsif action_name == 'edit'
      comment_path
    end
  end
end
