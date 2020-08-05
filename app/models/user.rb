class User < ApplicationRecord
  has_many :group_members
  has_many :groups, through: :group_members

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, password_strength: true
  validates :email, :presence => true, :uniqueness => true
  validates :first_name, :last_name, presence: true
  
  attr_accessor :access_code
  enum role: [:normal, :guest, :admin]

  def admin_groups
    group_ids = group_members.where(role: 0).map(&:group_id)
    return Group.find(group_ids) if group_ids.present?
    nil
  end
end
