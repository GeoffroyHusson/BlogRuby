class CommentObserver < ActiveRecord::Observer
	observe :user
  def after_create(comment)
    Notifier.comment_added(comment).deliver
  end
end

