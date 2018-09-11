module Api
  module V1
    class RentsController < ApiController
      def create
        rent = Rent.create(rents_create_params)

        if rent.save
          SendMailWorker.perform_async(rent.id)
        end

        render json: rent
      end

      def index
        render json: Rent.where(rents_index_params)
      end

      private

      def rents_create_params
        params.permit(:user_id, :book_id, :from, :to)
      end

      def rents_index_params
        params.permit(:user_id)
      end
    end
  end
end
