class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
    rescue_from ActiveRecord::RecordNotFound, with: :not_destroyed

    def not_destroyed
        render json: {message: "There is no such record to delete"}, status: :unprocessable_entity
    end
end
