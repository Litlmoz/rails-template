remove_file "app/helpers/application_helper.rb"

file "app/helpers/application_helper.rb", <<-RUBY
module ApplicationHelper
  #removed padding for day, month, and hour
  #added non-breaking space before PM
  def date_format(utc_date)
    utc_date.strftime("%-m/%-d/%y %-I:%M\u00A0%p")
  end
end
RUBY

# serialize json data into hash
file "app/serializers/hash_serializer.rb", <<-RUBY
class HashSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(json_string)
    hash = JSON.parse (json_string || "{}")
    return hash.with_indifferent_access
  end
end
RUBY
