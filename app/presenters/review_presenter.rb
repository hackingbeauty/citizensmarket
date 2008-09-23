class ReviewPresenter < ActivePresenter::Base
  presents :review, :issue
  
end