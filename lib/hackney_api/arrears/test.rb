require 'dotenv/load'
require 'savon'

module HackneyAPI
  module Arrears
    class Test
      def operations
        client.operations
      end

      def get_arrears_agreement_list
        client.call(:get_arrears_agreement_list, message: { dto: { agreement_search: { max_records: 10 } } })
      end

      private

      def wsdl_url
        "#{ENV['UH_WS_ENDPOINT']}/ArrearsAgreementService.svc?wsdl"
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
puts "Trying to retrieve a list of arrears agreements..."

puts test_api.get_arrears_agreement_list
