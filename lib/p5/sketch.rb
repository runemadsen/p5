module P5

	class Sketch

		def initialize(sketch_folder, output_folder = nil)
			@sketch_folder = sketch_folder
			@output_folder = output_folder || File.join(sketch_folder, "build")
		end

		def run
			puts @output_folder
  		Headless.ly do
  			`#{gem_root}/bin/processing/processing-java --sketch=#{@sketch_folder} --output=#{@output_folder} --force --run`
			end
		end

		private

		def gem_root
			File.expand_path '../../..', __FILE__
		end

	end

end