class Cat < ApplicationRecord
  validates :name, presence: true
  # nameが空でないことを検証
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # numericalityのオプションで、ageが整数であり、0以上であることを検証

  def self.ransackable_attributes(auth_object = nil)
    %w[id name age created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end


end
