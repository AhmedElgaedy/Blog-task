module Api
  module V1
    class PostsController < ApplicationController
      before_action :authorize_request
      before_action :set_post, only: [ :show, :update, :destroy ]

      def index
        @posts = Post.all
        render json: @posts
      end

      def show
        render json: @post
      end

      def create
        @post = current_user.posts.build(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @post.author == current_user && @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @post.author == current_user
          @post.destroy
          head :no_content
        else
          render json: { error: "Not authorized" }, status: :unauthorized
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, :tags)
      end
    end
  end
end
