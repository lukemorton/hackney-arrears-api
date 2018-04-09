require 'dotenv/load'
require 'savon'

module HackneyAPI
  module Arrears
    class Test
      def operations
        client.operations
      end

      def user_name_and_password
        direct_user
      end

      def get_arrears_agreement_list
        client.call(:get_arrears_agreement_list, message: {
          direct_user: direct_user,
          source_system: source_system,
          agreement_search: { max_records: 10 }
        })
      end

      private

      def wsdl_url
        "#{ENV['UH_WS_ENDPOINT']}/ArrearsAgreementService.svc?wsdl"
      end

      def direct_user
        {
          user_name: ENV['UH_WS_USER_NAME'],
          user_password: ENV['UH_WS_USER_PASSWORD']
        }
      end

      def source_system
        ENV['UH_WS_SOURCE_SYSTEM']
      end

      def client
        Savon.client(wsdl: wsdl_url)
      end
    end
  end
end

test_api = HackneyAPI::Arrears::Test.new

puts "We found some Arrears operations:"

test_api.operations.each do |operation|
   puts "- #{operation}"
end

puts
puts test_api.user_name_and_password

puts
puts "Trying to retrieve a list of arrears agreements..."

puts test_api.get_arrears_agreement_list
