module ReviewsHelper

  # see http://railscasts.com/episodes/75-complex-forms-part-3
  def fields_for_source(source, &block)
    prefix = source.new_record? ? 'new' : 'existing'

  end

  def setup_review(review)
    review.issues.build
    review
  end

end
