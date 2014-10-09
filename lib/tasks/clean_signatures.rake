require 'aws-sdk'
require 'colorize'

namespace :signatures do
  task :clean => [:environment] do

    puts '# Started signatures cleaning'.green

    s3 = AWS::S3.new
    bucket = s3.buckets[AWS_S3_BUCKET]

    bucket.objects.each { |object|
      print "Checking #{object.key} ... "
      removable = removable?(object)
      puts removable ? '[ delete ]'.colorize(:red) :
                       '[  keep  ]'.colorize(:green)
      object.delete if removable
    }

    puts '# Signatures cleaning ended'.green

  end

  def removable?(object)
    object.last_modified < Time.now - 1.month
  end

end