
Factory.define :admin do |a|
  a.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  a.password 'foo'
  a.created_at 'Wed Jul 01 00:23:27 -0400 2009'
  a.email 'foo'
end

Factory.define :brand do |b|
  b.name 'foo'
  b.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  b.description 'foo'
  b.company { |a| a.association(:company) }
  b.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end

Factory.define :company do |c|
  c.reviews_count 1
  c.city 'foo'
  c.name 'foo'
  c.industry 'foo'
  c.zip 1
  c.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  c.google_cid 1
  c.barcode 1
  c.country 'foo'
  c.website_url 'foo'
  c.stock_symbol 'foo'
  c.description 'foo'
  c.logo_url 'foo'
  c.state 'foo'
  c.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end

Factory.define :headquarter do |h|
  h.city 'foo'
  h.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  h.zipcode 'foo'
  h.country 'foo'
  h.company { |a| a.association(:company) }
  h.address 'foo'
  h.created_at 'Wed Jul 01 00:23:27 -0400 2009'
  h.state 'foo'
end

Factory.define :issue do |i|
  i.name 'foo'
  i.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  i.category 'foo'
  i.description 'foo'
  i.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end

Factory.define :peer_rating do |p|
  p.score 1
  p.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  p.review { |a| a.association(:review) }
  p.user { |a| a.association(:user) }
  p.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end

Factory.define :review do |r|
  r.rating 1
  #r.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  r.body 'factory review body'
  r.company { |a| a.association(:company) }
  r.user { |a| a.association(:user) }
  #r.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end

Factory.define :review_issue do |r|
  r.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  r.issue { |a| a.association(:issue) }
  r.review { |a| a.association(:review) }
  r.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end

Factory.define :user do |u|
  u.salt 'foo'
  u.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  u.activated_at 'Wed Jul 01 00:23:27 -0400 2009'
  u.crypted_password 'foo'
  u.deleted_at 'Wed Jul 01 00:23:27 -0400 2009'
  u.activation_code 'foo'
  u.remember_token_expires_at 'Wed Jul 01 00:23:27 -0400 2009'
  u.lastname 'foo'
  u.firstname 'foo'
  u.reset_code 'foo'
  u.remember_token 'foo'
  u.login 'foo@some.com'
  u.created_at 'Wed Jul 01 00:23:27 -0400 2009'
  #u.state 'foo'
  u.email 'foo@some.com'
end

Factory.define :user_issue do |u|
  u.updated_at 'Wed Jul 01 00:23:27 -0400 2009'
  u.weight 1
  u.issue { |a| a.association(:issue) }
  u.user { |a| a.association(:user) }
  u.created_at 'Wed Jul 01 00:23:27 -0400 2009'
end
