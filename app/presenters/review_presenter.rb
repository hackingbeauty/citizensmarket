class ReviewPresenter < ActivePresenter::Base
  presents :review, :review_issue
  
end