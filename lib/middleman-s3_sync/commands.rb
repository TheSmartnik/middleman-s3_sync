require 'middleman-core/cli'
require 'middleman-s3_sync/extension'

module Middleman
  module Cli
    class S3Sync < Thor
      include Thor::Actions
      namespace :s3_sync

      def self.exit_on_failure?
        true
      end

      desc "s3_sync", "Builds and push the minimum set of files needed to S3"
      option :force, type: :boolean,
                     desc: "Push all local files to the server",
                     aliases: :f
      def s3_sync
        shared_inst = ::Middleman::Application.server.inst
        bucket = shared_inst.options.bucket
        if (!bucket)
          raise Thor::Error.new "You need to activate this extension."
        end

        shared_inst.options.force = options[:force] if options[:force]

        ::Middleman::S3Sync.sync
      end
    end
  end
end
