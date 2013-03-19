module P5

	class Sketch

		def initialize(sketch_folder, output_folder = nil)
			@sketch_folder = sketch_folder
			@output_folder = File.join(sketch_folder, "build") if output_folder.nil?
		end

		def run
			Headless.ly do
  			`bin/processing/processing-java --sketch=#{@sketch_folder} --output=#{@output_folder} --force --run`
			end
		end

	end

end