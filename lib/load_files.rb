require "date"
class LoadFiles
  attr_reader :data, :code_file, :args
  def initialize
    get_args
    @data_file = "data/live/day_#{@args[:day_str]}.txt"
    @sample_data_file = "data/sample/day_#{@args[:day_str]}.txt"
    @code_file = "lib/daily/day_#{@args[:day_str]}.rb"
    create_files
    @data = get_data
  end

  def get_data(sample_data = @args[:sample])
    if sample_data
      File.read(@sample_data_file)
    else
      File.read(@data_file)
    end
  end

  private

    def get_args
      @args = {}
      ARGV.each do |arg|
        if arg.to_s.to_i.to_s == arg
          @args[:day_str] = arg.to_s.to_i.to_s.rjust(2, "0")
        elsif arg.downcase == "sample"
          @args[:sample] = true
        end
      end
      @args[:day_str] ||= Date.today.day.to_s.rjust(2, "0")
      @args[:sample] ||= false
    end

    def create_files
      # I want all the files if they don't already exist
      File.exist?(@code_file) || FileUtils.cp("lib/daily_stub.rb",@code_file)
      File.exist?(@data_file) || FileUtils.touch(@data_file)
      File.exist?(@sample_data_file) || FileUtils.touch(@sample_data_file)
    end
end
