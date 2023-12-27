class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable 
  has_many :work_experiences, dependent: :destroy
  has_many :connections, dependent: :destroy
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
        def my_connection(user)
          Connection.where("(user_id = ? AND connected_user_id = ?) OR (user_id= ? AND connected_user_id = ?)", user.id,id, id, user.id)
        end
      def check_already_connected?(user)
        self != user && !my_connection(user).present?
      end
end
