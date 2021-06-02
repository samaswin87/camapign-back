require 'faker'

class Demo
  def initialize
    setup_companies
    setup_users
    setup_platforms
  end

  private

  def setup_platforms
    setup_operators
    setup_recipients
  end

  def setup_operators
    puts "Creating operators"
    (1..100).each do |index|
      (1..5).each do |index|
        print "."
        Platform::Operator.create({
          status: 0,
          phone: Faker::PhoneNumber.cell_phone,
          company_id: index,
          name: Faker::Company.name,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nOperators creation completed"
  end

  def setup_recipients
    puts "Creating recipients"
    (1..100).each do |index|
      (1..5).each do |index|
        print "."
        Platform::Recipient.create({
          status: 0,
          phone: Faker::PhoneNumber.cell_phone,
          email: Faker::Internet.email,
          company_id: index,
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          created_by_id: 1,
          updated_by_id: 1
        })
      end
    end
    puts "\nRecipients creation completed"
  end

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
    puts "\nCompanies creation completed"
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
      (1..5).each do |user|
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
    puts "\nUsers creation completed"
  end
    
end