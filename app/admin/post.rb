ActiveAdmin.register Post do
  permit_params :title, :body, :posted_at, :status
  
  controller do
    def new
      @post = Post.new
      @post.posted_at = Time.new
      @post.status = Post::STATUS_PRIVATE
    end

    def create
      @post = Post.new(post_params)
      @post.tag_list = params[:post][:tag_list].split(',')

      if @post.save
        render 'show'
      else
        render 'new'
      end
    end

    private
    def post_params
      params.require(:post).permit(:title, :body, :posted_at, :status)
    end
  end

  member_action :preview do
    @post = Post.find(params[:id])
    render layout: 'admin/layouts/application'
  end


  action_item :only => :show do
    if controller.action_methods.include?('preview')
      link_to('Preview', preview_admin_post_path(resource))
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :tag_list
      f.input :body, as: :text
      f.input :posted_at, as: :datetime_picker
      f.input :status, as: :radio, collection: Post::STATUS_VALUES
    end
    f.actions
  end

  show do |post|
    attributes_table do
      row :title do
        post.title
      end
      row :tag do
        post.tag_list
      end
      row :body do
        post.body
      end
      row :posted_at do
        post.posted_at
      end
      row :created_at do
        post.created_at
      end
      row :updated_at do
        post.updated_at
      end
    end
  end
end
