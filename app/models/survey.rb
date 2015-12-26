class Survey < ApplicationRecord

  has_many :survey_options
  has_many :survey_answers

  accepts_nested_attributes_for :survey_options, :allow_destroy => true

  validates_presence_of :title 

  # Scopes
  scope :actives, lambda {
    {:conditions => {:active => true}}
  }

  def result

    options = {}
    survey_answers.each do |answer|
      options[answer.survey_option] ||= 0
      options[answer.survey_option] += 1
    end

    total = survey_answers.count

    result = {}
    options.each do |key,value|
      result[key] = ((value * 100)/total).to_i
    end
    result
  end

  def can_answer?(user)
    not (survey_answers.where(:user_id => user.id).count > 0)
  end
end
