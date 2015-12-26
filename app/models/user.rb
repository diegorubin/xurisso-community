class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :birthday_str

  mount_uploader :avatar, AvatarUploader

  #validates
  validates_format_of :login, :with => /\A[a-zA-Z0-9]{4,40}\z/
  validates_uniqueness_of :email, :login

  # Relations
  has_many :albums
  has_many :received_messages, -> {where(removed_by_to: false)},
                               :class_name => "Message",
                               :foreign_key => "to_id" 

  has_many :sent_messages, -> {where(removed_by_from: false)},
                           :class_name => "Message", 
                           :foreign_key => "from_id"

  has_and_belongs_to_many :events

  # Scopes
  default_scope -> {where(removed: false)}
  scope :find_by_login_or_id, lambda { |login, id|
    where(["login = ? or id = ?", login, id])
  }

  scope :except_user, lambda { |user|
    where(["id != ?", user.id])
  }

  scope :birthdays_of_period, lambda { |start_at, end_at|
    where(["((MONTH(users.birthday) = ? AND DAY(users.birthday) >= ?)", start_at.month, start_at.day])
      .or(["(MONTH(users.birthday) = ?)", start_at.month + 1])
      .or(["(MONTH(users.birthday) = ? AND DAY(users.birthday) <= ?)) AND can_display_birthday = ?", end_at.month, end_at.day, true])
  }

  # Callbakcks
  before_save :set_birthday

  # pagination
  paginates_per 10

  def identifier
    name.blank? ? (login || email) : name
  end

  def active_for_authentication? 
    super && !blocked? 
  end 

  def remove
    update_attribute(:removed, true)
  end

  def birthday_str
    birthday ? birthday.strftime('%d/%m/%Y') : ""
  end

  def answer_of(survey)
    SurveyOption.answer_of_user_for_survey(id, survey.id).first
  end

  private
  def set_birthday
    write_attribute(:birthday, Date.strptime(@birthday_str, '%d/%m/%Y')) unless @birthday_str.blank?
  end

end

