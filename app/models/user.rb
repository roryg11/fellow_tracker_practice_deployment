class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :goals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :cohorts, through: :memberships
  has_many :memberships
  self.inheritance_column = :role

  def self.roles
    %w(Fellow Coach Staff)
  end

  scope :fellows, -> {where(role: 'Fellow')}
  scope :coaches, -> {where(role: 'Coach')}
  scope :staff, -> {where(role: 'Staff')}

  def fellow?
    role == 'Fellow'
  end
end
