namespace :user do
  desc "Generate user qr code for user who has no qr code"
  task gen_qr_code: :environment do
    User.find_each(batch_size: 100) do |user|
      user.create_qr_code unless user.qr_code_existing?
    end
  end
end
