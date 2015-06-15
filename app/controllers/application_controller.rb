class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four

  def four_oh_four
    head 404
  end

end
