module Api
  class RacersController < ApiController

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:id]}"
      else
        #real implementation ...
      end
    end

  end
end
