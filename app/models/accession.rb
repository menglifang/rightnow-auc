class Accession < ActiveRecord::Base
  belongs_to :application, class_name: 'Doorkeeper::Application'
  belongs_to :user

  attr_accessible :admin, :application, :application_id
end
