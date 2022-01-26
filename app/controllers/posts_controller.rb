class PostsController < ApplicationController
  def create
    is_posted = Post::Creator.call(
      current_user,
      permitted_params
    )
    flash[:alert] = 'Something went wrong' unless is_posted
    redirect_back fallback_location: timelines_path
  end

  private

  def permitted_params
    params.require(:post).permit(
      :postable_type,
      :status_text,
      :sight_place_id,
      :thread_id,
      :pictures => [],
    )
  end
end
