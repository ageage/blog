AdminUser.create!(
    email: ENV['BLOG_ADMIN_EMAIL'],
    password: ENV['BLOG_ADMIN_PASSWORD'],
    password_confirmation: ENV['BLOG_ADMIN_PASSWORD_CONFIRMATION']
)