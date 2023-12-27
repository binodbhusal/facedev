class WorkExperience < ApplicationRecord

  EMPLOYMENT_TYPE = ['Full-time', 'Part-time', 'Freelance', 'Self-employed',
   'Trainee', 'Internship']
   LOCATION_TYPE = ['On-site','Hybrid', 'Remote']
  belongs_to :user
  validates :start_date, :company, :job_title, :location, presence:true
  validates :employment_type, presence: true, inclusion: {in: EMPLOYMENT_TYPE, message:'is not a valid employment type'}
  validates :location_type, presence: true, inclusion: {in: LOCATION_TYPE, message:'is not a valid location type'}

  validate :work_experiences_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date

              def end_date_greater_than_start_date if: :currently_not_working_here?
                return if end_date.nil?
                if end_date < start_date
                  errors.add(:end_date, 'must be greater than start date')
                end
              end
              def currently_not_working_here?
                !currently_working_here
              end
              def work_experiences_last_date
                if end_date.present? && currently_working_here
                  errors.add(:end_date, 'must be blank if you select currently working here')
                end
              end
              def presence_of_end_date
                if end_date.nil? && !currently_working_here
                  errors.add(:end_date,'must be present if you are not selected currently working here')
              end
            end
            def company_with_employment_type
              "#{company} (#{employment_type})".strip
            end
            def job_duration
              months = 
                    if end_date.present?
                  fetch_months(end_date)
                    else 
                    fetch_months(Date.today)
                    end
                    result = months.divmod(12)
                    duration = "#{result.first} #{result.first > 1 ? 'years' : 'year' }#{result.last} #{result.last > 1 ? 'months' : 'month' }"

                    if currently_working_here 
                    "#{start_date.strftime("%b %y")} - Present (#{duration})"
                    else
                      "#{start_date.strftime("%b %y")} - #{end_date.strftime("%b %y")}(#{duration})"

                    end
            end
            def fetch_months(last_date)
              ((last_date.year - start_date.year) * 12 + last_date.month - start_date.month - (last_date.day >= start_date.day ? 0 : 1)).round
            end
end
