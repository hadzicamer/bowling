module Api
  module V1
    class RollsController < Api::V1::BaseController
      def create
        contract = RollContract.new.call(roll_params)
        if contract.success?
          game = Game.find(params[:game_id])
          roll = AddRollCommand.call(game, contract[:pins])
          render json: roll, status: :created
        else
          render json: { errors: contract.errors.to_h }, status: :unprocessable_entity
        end
      end

      private

      def roll_params
        params.require(:roll).permit(:pins)
      end
    end
  end
end
