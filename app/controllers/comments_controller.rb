module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_request
      before_action :set_post
      before_action :set_comment, only: [ :update, :destroy ]

      def create
        @comment = @post.comments.build(comment_params.merge(user: current_user))
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def update
        if @comment.user == current_user && @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @comment.user == current_user
          @comment.destroy
          head :no_content
        else
          render json: { error: "Not authorized" }, status: :unauthorized
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_comment
        @comment = @post.comments.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
