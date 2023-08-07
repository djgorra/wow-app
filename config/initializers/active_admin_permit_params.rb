ActiveAdmin::ResourceController.class_eval do
  # Allow ActiveAdmin admins to freely mass-assign when using strong_parameters
  def resource_params
    [(params[resource_request_name] || params[resource_instance_name]).try(:permit!) || {}]
  end
end

#i.e. fix bug between ActiveAdmin and will_paginate
# see https://github.com/activeadmin/activeadmin/issues/5239
module ActiveRecord
  class Relation
    alias_method :total_count, :count
  end
end
