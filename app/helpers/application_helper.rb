module ApplicationHelper

  def commercial_situation(situation)
    color = { release: 'purple', sale: 'orange', rent: 'teal' }
    color[situation.to_sym]
  end

end
