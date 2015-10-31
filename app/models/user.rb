class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable
  
  devise    :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable

  has_many  :items, dependent: :destroy    
  belongs_to :role

  before_create :set_default_role

  include UserModelFilter #include User model concern
end
