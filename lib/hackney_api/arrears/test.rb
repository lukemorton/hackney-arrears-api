require 'dotenv/load'
require 'savon'

module OverrideMessageTag
  def namespaced_message_tag
    [message_tag, message_attributes.merge(xmlns: 'http://schemas.civica.co.uk/UHWeb/2013/03')]
  end
end

Savon::Builder.prepend(OverrideMessageTag)

module HackneyAPI
  module Arrears
    class Test
      def operations
        client.operations
      end

      def get_arrears_agreement_list
        client.call(:get_arrears_agreement_list, message: {
          dto: {
            DirectUser: direct_user,
            SourceSystem: source_system,
            AgreementSearch: { MaxRecords: 10 }
          }
        })
      end

      private

      def wsdl_url
        "#{ENV['UH_WS_ENDPOINT']}/ArrearsAgreementService.svc?wsdl"
      end

      def direct_user
        {
          UserName: ENV['UH_WS_USER_NAME'],
          UserPassword: ENV['UH_WS_USER_PASSWORD']
        }
      end

      def source_system
        ENV['UH_WS_SOURCE_SYSTEM']
      end

      def client
        Savon.client(
          convert_request_keys_to: :none,
          log: false,
          wsdl: wsdl_url
        )
      end
    end
  end
end

test_api = HackneyAPI::Arrears::Test.new

puts 'We found some Arrears operations:'

test_api.operations.each do |operation|
   puts "- #{operation}"
end

puts
puts 'Trying to retrieve a list of arrears agreements...'

puts test_api.get_arrears_agreement_list
