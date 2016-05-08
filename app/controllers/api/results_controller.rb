module Api
  class ResultsController < ApiController

    def index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        @race = Race.find(params[:race_id])
        @entrants = @race.entrants
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        result = Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
        render :partial => "result", :object => result, status: :ok
      end
    end

    def update
      entrant = Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
      result = params[:result]
      if result
        if result[:swim]
          entrant.swim = entrant.race.race.swim
          entrant.swim_secs = result[:swim].to_f
        end
        if result[:t1]
          entrant.t1=entrant.race.race.t1
          entrant.t1_secs = result[:t1].to_f
        end
        saved = entrant.save
        # puts "saved: #{saved}"
        # puts entrant.errors.inspect
      end
      render :partial => "result", :object => entrant, status: :ok
    end

  end
end
