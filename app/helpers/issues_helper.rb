module IssuesHelper
  def to_stars
    value = self / 2
    if value > 5.0
      value = 5.0
    end
    whole = value.to_i
    part = value - value.to_i
    if part < 0.25
      return whole
    elsif part < 0.75
      return whole + 0.5
    else
      return whole + 1
    end
  end
end

class Float; include IssuesHelper; end
