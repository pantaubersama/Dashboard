require 'csv'
require 'json'

module ConvertJsonToCsv
  def json_to_csv(json_file, csv_file)
    json_array = json_file
    headers = collect_keys(json_array.first) 
    CSV.generate(:headers => true) do |csv|
      csv << headers
      json_array.each { |item| csv << collect_values(item) }
    end
  end
  
  def collect_keys(hash, prefix = nil)
    arr = hash.map do |key, value|
      if value.class != Hash
        if prefix
          "#{prefix}.#{key}"
        else
          key
        end
      else
        if prefix
          collect_keys(value, "#{prefix}.#{key}")
        else
          collect_keys(value, "#{key}")
        end
      end
    end
    arr.flatten
  end
  
  def collect_values(hash)
    arr = hash.map do |key, value|
      if value.class != Hash
        if (value.class == Array)
          value.join(',')
        else
          value
        end
      else
        collect_values(value)
      end
    end
    arr.flatten
  end
end
