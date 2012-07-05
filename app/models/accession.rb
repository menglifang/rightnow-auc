class Accession < ActiveRecord::Base
  belongs_to :application
  belongs_to :user

  attr_accessible :admin
end
