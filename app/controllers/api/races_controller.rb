module Api
  class RacesController < ApiController

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
    end

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
        #render plain: "/api/races/#{params[:id]}"
        render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
      else
        begin
          race = Race.find_by(id: params[:id])
          render race, status: :ok
        rescue Exception
          render :status => :not_found,
                 :template => "api/error_msg",
                 :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]"}
        end
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
