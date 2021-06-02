require 'faker'

class Demo
  def initialize
    setup_companies
    setup_users
  end

  private

  def setup_companies
    puts "Creating Companies"
    (0..4).each do |plan|
      (1..20).each do |index|
        print "."
        Company.create(
          {
            status: 0,
            name: Faker::Company.name,
            email: Faker::Internet.email,
            phone: Faker::PhoneNumber.cell_phone,
            plan: plan,
            call_forwarding: false,
            total_credits: 1000,
            remaining_credits: 100,
            message_forward: true,
            plan_credits: 10000,
            credit_percentage: 0,
          })
      end
    end
    puts "Companies creation completed"
  end

  def setup_users
    puts "Creating Users"
    (1..100).each do |index|
      print "."
      User.create(
        {
          status: 0,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          role: 0,
          company_id: index,
          email: Faker::Internet.email,
          password: 'password',
          password_confirmation: 'password'
        }
      )
    end

    (1..100).each do |index|
      (1..10).each do |user|
        print "."
        User.create(
          {
            status: 0,
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            role: 1,
            company_id: index,
            email: Faker::Internet.email,
            password: 'password',
            password_confirmation: 'password'
          }
        )
      end
    end
    puts "Users creation completed"
  end
    
end