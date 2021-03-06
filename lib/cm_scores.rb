class CmScores
  
  # Contributor Score (user) :        CS = s * ((x * LRS) + LR)
  USER_CONTRIBUTOR_SCORE_S = 10
  USER_CONTRIBUTOR_SCORE_X = 1
  
  # Lifetime Review Score (user) :    LRS = RS + RS + RS + ... + RS  [sum of review scores]
  # Lifetime Reviews (user) :         LR = user.reviews.size  [number of reviews]
  # Contributor Level (user ) :       CL = based on how many points you get: 0 => level 1, etc
  USER_CONTRIBUTOR_LEVEL_PROMOTIONS_AT = [0, 50, 100, 200, 300, 500, 700, 1000, 1300, 1700, 2100, 2600, 3100, 3700, 4300, 5000] # numbers are versus CS
  
  # My Company Score (company, user) :  MCS = sum(IS * IW) / sum(IW)   [weighted average of issue scores, by issue weights]
  # Generic Company Score (company, user) : GCS = sum(IS)/count(IS)   [simple average of issue scores]
  # Issue Score (company, issue) :    IS =  sum(rating * QF) / sum(QF) [average of review ratings, weighted by Quality Factor]
  # Quality Factor (review) :         QF = CL + (y * RS)               [if QF < 0, then QF is set to 0]
  # Review Score (review) :           RS = sum(peer_rating.score)      [all the up votes, minus the down votes]
  
  REVIEW_NON_NEGATIVE_QUALITY_FACTOR_Y = 0.07
  REVIEW_QUALITY_FACTOR_Y = 1
  
  
  
  def self.company_issue_score(company, issue)
    
    # return cached if it exists
    
    company = Company.find(company) if company.class == Fixnum
    issue = Issue.find(issue) if issue.class == Fixnum
    
    return nil if company.reviews.size == 0
    
    numerator = 0
    denominator = 0
    
    company.reviews_for_issue(issue).each do |r|
      next if CmScores.review_quality_factor(r).nil?
      qf = CmScores.review_quality_factor(r)
      numerator += r.rating * qf
      denominator += qf
    end
    
    return nil if denominator == 0

    numerator.to_f / denominator.to_f    
     
  end
  
  def self.review_score(review)
    
    review = Review.find(review) if review.class == Fixnum
    
    CACHE.fetch("CmScores.review_score(review_id=#{review.id})", 1.hour){
      output = 0
      review.peer_ratings.each do |pr|
        output += pr.score
      end
      output
    }
  end
  
  def self.review_non_negative_quality_factor(review, quality_factor = nil)
    qf ||= CmScores.review_quality_factor(review)
    y = CmScores::REVIEW_NON_NEGATIVE_QUALITY_FACTOR_Y
    
    (Math.exp(qf)/(Math.exp(1) - y)**qf)
  end
  
  def self.review_quality_factor(review)
    # return cached if it exists
    review = Review.find(review) if review.class == Fixnum
    y  = CmScores::REVIEW_QUALITY_FACTOR_Y
    cl = CmScores.user_contributor_level(review.user)
    rs = CmScores.review_score(review)
    output = cl + (y * rs)
    output = 0 if output < 0
    output
  end
  
  def self.user_contributor_score(user)
    # return cached if it exists
    user = User.find(user) if user.class == Fixnum
    s = CmScores::USER_CONTRIBUTOR_SCORE_S
    x = CmScores::USER_CONTRIBUTOR_SCORE_S
    output = s * ((x * CmScores.user_lifetime_review_score(user)) + CmScores.user_lifetime_reviews(user))
  end
  
  def self.user_lifetime_review_score(user)
    # return cached if it exists
    user = User.find(user) if user.class == Fixnum
    output = 0
    user.reviews.each do |r|
      output += self.review_score(r)
    end
    output
  end
  
  def self.user_lifetime_reviews(user)
    # return cached if it exists
    user = User.find(user) if user.class == Fixnum
    user.reviews.size
  end
  
  def self.user_contributor_level(user)
    user = User.find(user) if user.class == Fixnum
    CACHE.fetch("CmScores.user_contributor_level(user_id=#{user.id})"){
      promotions_at = CmScores::USER_CONTRIBUTOR_LEVEL_PROMOTIONS_AT
      cs = CmScores.user_contributor_score(user)
      output = 0
      found = false
      promotions_at.each do |n|
        if n > cs
          output = promotions_at.index(n)
          found = true
          break
        end
      end
      unless found 
        output = promotions_at.size
      end
      output
    }
  end
  
  def self.my_company_score(company, user)
    company = Company.find(company) if company.class == Fixnum
    user = User.find(user) if user.class == Fixnum
    
    CACHE.fetch("CmScores.my_company_score(company_id=#{company.id},user_id=#{user.id})"){
      output = 0
      numerator = 0
      denominator = 0
      user.user_issues.each do |ui|
        issue_score = CmScores.company_issue_score(company, ui.issue)
        next if issue_score.nil?
        numerator += ui.weight * issue_score
        denominator += ui.weight
      end
      if denominator.to_i == 0
        output = numerator if denominator.to_i == 0  # if user has all weights set to 0, equivalent to all weights set to 1, because all weights are set equally
      else
        output = numerator.to_f / denominator.to_f
      end
      output
    }
    
  end
  
  def self.generic_company_score(company)
    
    company = Company.find(company) if company.class == Fixnum
    
    CACHE.fetch("CmScores.generic_company_score(company_id=#{company.id})"){
      output = 0
      numerator = 0
      denominator = 0
      Issue.all.each do |issue|
        issue_score = CmScores.company_issue_score(company, issue)
        next if issue_score.nil?
        numerator += issue_score
        denominator += 1
      end
      
      if denominator.to_i == 0
        output = numerator
      else
        output = numerator.to_f / denominator.to_f
      end
      output
    }
    
  end
  
end