class SpecRunner
  attr_accessor :klasses

  def initialize
    @klasses = []

    Dir["./specs/*.rb"].each do |file|
      require file
      # Create a new class form file name
      @klasses << file.new
    end
  end

  def call
    @klasses.each do |klass|
      puts klass.call
    end
  end
end