class CmCsv

  attr_accessible :csv_file

end

def sample_of_usage_with_populator

  # code I wish I had

  cm_csv = CmCsv.open(RAILS_ROOT+'/db/development_companies.csv')

  while c = cm_csv.get_me_a(Company)

    Company.populate 1 do |company|
      company = c
    end

  end

end
