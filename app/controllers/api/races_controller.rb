module Api
  class RacesController < ApiController

    def index
      offset = params[:offset]
      limit = params[:limit]
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races, offset=[#{offset}], limit=[#{limit}]"
      else
        #real implementation ...
      end
    end

    def create
      if !request.accept || request.accept == "*/*"
        render plain: :nothing, status: :ok
      else
        #real implementation
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        #real implementation ...
      end
    end

  end
end
