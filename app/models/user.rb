class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accessions, dependent: :destroy
  has_many :applications, through: :accessions

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :remember_me, :role, :accessions_attributes

  default_value_for :role, :user

  accepts_nested_attributes_for :accessions

  def admin?
    role.to_sym == :admin
  end

  def has_access_to?(app)
    accessions.exists?(application_id: app.id)
  end

  def admin_of?(app)
    accessions.exists?(application_id: app.id, admin: true)
  end

  def brief
    email
  end

  class << self
    def of_application(app)
      User.joins(:applications).where(applications: { id: app.id })
    end

    alias of_app of_application
  end
end
