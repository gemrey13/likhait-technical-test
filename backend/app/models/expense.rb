class Expense < ApplicationRecord
  belongs_to :category

  # Custom validation error messages for presence and numeric checks
  validates :description, presence: { message: "is required and cannot be blank" }
  validates :category_id, presence: { message: "must be selected" }
  validates :date, presence: { message: "is required" }
  
  validates :amount, presence: { message: "is required" },
  numericality: { greater_than: 0, message: "must be a number greater than $0.00" }

  # Custom validation for expense date
  validate :date_cannot_be_in_the_future

  private

  def date_cannot_be_in_the_future
    if date.present? && date > Time.now.utc.to_date
      errors.add(:date, "cannot be set to a future date (selected date: #{date})")
    end
  end
end