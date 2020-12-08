class Meeting < ApplicationRecord
  before_create :set_id
  def set_id
    # meeting作成時に10桁のrandom numberをふる
    self.id = ''.tap { |s| 10.times { s << rand(0..9).to_s } }
  end
end
