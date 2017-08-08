ActiveAdmin.register Post do
  permit_params :title, :body, :posted_at, :status


  # form(:html => { :multipart => true }) do |f|
  #   f.inputs '詳細' do
  #     f.input :title
  #     f.input :body
  #     f.input :posted_at, as: :datatime_picker
  #     f.input :status, as: :select, collection: Post::STATUS_VALUES
  #   end
  # end
  form(:html => { multipart: true }) do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :text
      f.input :posted_at, as: :datetime_picker
      f.input :status, as: :radio, collection: Post::STATUS_VALUES
    end
    f.actions
  end
end
