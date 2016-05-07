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
        race = Race.create(whitelist)
        render plain: race.name, status: :created
      end
    end

    def update
      #Rails.logger.debug("method=#{request.method}")
      race = Race.find_by(id: params[:id])
      race.update(whitelist)
      render json: race
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:id]}"
      else
        race = Race.find_by(id: params[:id])
        render json: race
      end
    end

    def destroy
      race = Race.find_by(id: params[:id])
      race.destroy
      render :nothing => true, :status => :no_content
    end

    private
      def whitelist
        params.require(:race).permit(:name, :date)
      end

  end
end
