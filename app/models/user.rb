class User < ApplicationRecord
    has_secure_password
    enum role: { developer: 0, admin: 1, employee: 2 }
  
    validates :username, presence: true, uniqueness: true
    validates :employee_id, presence: true, uniqueness: true
  end
  