module Fastlane
  module Actions
    class GmailAction < Action
      def self.run(params)
        require 'mail'

        Mail.defaults do
          if params[:password]
            delivery_method :smtp, {
              address:              'smtp.gmail.com',
              port:                 587,
              user_name:            params[:username],
              password:             params[:password],
              authentication:       'plain',
              enable_starttls_auto: true
            }
          else
            delivery_method :smtp, {
              port: 587,
              address: "smtp-relay.gmail.com",
              domain: params[:domain]
            }
          end
        end

        Mail.deliver do
          from     params[:username]
          to       params[:to]
          cc       params[:cc]
          subject  params[:subject]
          html_part do
            content_type 'text/html; charset=UTF-8'
            body params[:body]
          end
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :domain,
                                       env_name: "FL_GMAIL_DOMAIN",
                                       description: "G Suite domain",
                                       optional: true,
                                       default_value: "gmail.com",
                                       verify_block: proc do |value|
                                         UI.user_error!("No domain") if value.to_s.length == 0
                                       end),
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: "FL_GMAIL_USERNAME",
                                       description: "Username for gmail",
                                       verify_block: proc do |value|
                                         UI.user_error!("No username") if value.to_s.length == 0
                                       end),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_GMAIL_PASSWORD",
                                       description: "Password for gmail",
                                       optional: true,
                                       sensitive: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("No password") if value.to_s.length == 0
                                       end),
          FastlaneCore::ConfigItem.new(key: :to,
                                       env_name: "FL_GMAIL_TO",
                                       description: "Mail to recipients",
                                       sensitive: true,
                                       is_string: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("No recipients") if value.to_s.length == 0
                                       end),
          FastlaneCore::ConfigItem.new(key: :cc,
                                       env_name: "FL_GMAIL_CC",
                                       description: "Mail cc recipients",
                                       sensitive: true,
                                       is_string: false),                             
          FastlaneCore::ConfigItem.new(key: :subject,
                                       env_name: "FL_GMAIL_SUBJECT",
                                       description: "The subject of the email",
                                       sensitive: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("No subject of email") if value.to_s.length == 0
                                       end),
          FastlaneCore::ConfigItem.new(key: :body,
                                       env_name: "FL_GMAIL_BODY",
                                       description: "The body of the email",
                                       sensitive: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("No body of email") if value.to_s.length == 0
                                       end)
        ]
      end

      def self.authors
        ["Alexander-Ignition"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
