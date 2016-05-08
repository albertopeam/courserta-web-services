module Api
  class RacesController < ApiController

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      #Rails.logger.debug exception
      render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
    end

    rescue_from ActionView::MissingTemplate do |exception|
      #Rails.logger.debug exception
      render plain: "woops: we do not support that content-type[#{request.accept}]",
             status: :unsupported_media_type
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
        if has_race && has_name
          render plain: whitelist[:name], status: :ok
        else
          render plain: :nothing, status: :ok
        end
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
        #render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
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

      def has_race
        !params[:race].nil?
      end

      def has_name
        !params[:race][:name].nil?
      end

  end
end
