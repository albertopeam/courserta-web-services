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
        render plain: whitelist[:name], status: :ok
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

    private
      def whitelist
        params.require(:race).permit(:name)
      end

  end
end
