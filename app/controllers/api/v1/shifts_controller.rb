module Api::V1
  class ShiftsController < ApiController
    before_action :set_shift, only: [:show]
    def index
        @shifts = Shift.alphabetical.all
        render json: ShiftSerializer.new(@shifts).serialized_json
      end

     # GET
     def show
        render json: ShiftSerializer.new(@shift).serialized_json
      end
    
      private
      # Use callbacks to share common setup or constraints between actions.
      def set_shift
        @shift = Shift.find(params[:id])
      end

  end
end