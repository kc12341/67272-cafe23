module Api::V1
  class StoresController < ApiController
    before_action :set_store, only: [:show]
    before_action :set_shifts, only: [:upcoming_shifts]

    def index
        @stores = Store.alphabetical.all
        render json: StoreSerializer.new(@stores).serialized_json
      end

     # GET
     def show
        # puts params[:upcoming].present?
          render json: StoreSerializer.new(@store).serialized_json
      end

      def upcoming_shifts
          render json: ShiftUpcomingSerializer.new(@shifts).serialized_json
        end
    
      private
      # Use callbacks to share common setup or constraints between actions.
      def set_store
        @store = Store.find(params[:id])
      end

      def set_shifts
        @shifts = Shift.for_store(Store.find(params[:id])).upcoming.chronological.all
      end
    
  end
end