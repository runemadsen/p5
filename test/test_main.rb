require './test/helper'

class MainTest < Test::Unit::TestCase

  def test_run_sketch
    assert !File.exist?("test/test_sketch/grab.png")
    sketch = P5::Sketch.new("#{File.dirname(__FILE__)}/test_sketch")
    sketch.run
    assert File.exist?("test/test_sketch/grab.png")
    File.delete("test/test_sketch/grab.png")
  end

  def test_run_sketch_other_folder
    sketch = P5::Sketch.new("#{File.dirname(__FILE__)}/test_sketch", "#{File.dirname(__FILE__)}/abuildfolder")
    sketch.run
  end

end