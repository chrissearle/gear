class StaticsController < ApplicationController
  layout :resolve_layout

  def welcome
  end

  def social
  end

  private

  def resolve_layout
    case action_name
      when "welcome"
        "wide"
      else
        "application"
    end
  end
end
