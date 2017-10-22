require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

namespace :splits do
  desc "set display values for split times"
  task set_string_value: :environment do
    Split.all.each do |s|
      s.save
   end
  end

end
