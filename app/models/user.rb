class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable 

         PROFILE_TITLE = [
        'Fullstack Developer',
        'Frondend Developer',
        'Backend Developer',
        'React Developer',
        'Ruby on Rails Developer',
        'Senior Ruby on Rails Developer',
        'Data Scientist',
        'Software Engineer',
        'Java Developer',
        'Python Developer',
        'Devops Developer',
        'Cloud Developer',
        'Software Architect'
].freeze
         def name
          "#{first_name} #{last_name}".strip
         end

         def self.ransackable_associations(auth_object = nil)
          []
        end
        def self.ransackable_attributes(auth_object = nil)
          ['country', 'city']
        end
      
end
