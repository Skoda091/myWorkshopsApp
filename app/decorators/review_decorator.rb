class ReviewDecorator < Draper::Decorator
  decorates :review
  delegate_all

  def author
	review.user.firstname + " " + review.user.lastname
  end

end
