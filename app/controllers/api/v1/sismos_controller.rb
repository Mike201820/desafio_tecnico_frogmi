class Api::V1::SismosController < ApplicationController
  def index

    sismos = Sismo.all
    render json: sismos, status: :ok

  end

  def create_comment
    sismo = Sismo.find(params[:sismo_id])
        comment = sismo.comments.create(comment_params)
        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end

        private

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  
end
