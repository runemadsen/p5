# P5

P5 is a ruby gem that makes it easy to run Processing sketches on a headless web server.

## What's in it, what's not

This gem ships with a full version of Processing, with all of the examples and UI components removed. It currently amounts to 30mb.

This gem does not ship with a version of xvfb, which is needed to run the gem. **You will need to install xvfb** in order to make this gem work. If you have a slice on Rackspace or something like this, it should be as easy as `apt-get install xvfb`. If you're on Heroku, [good luck](https://gist.github.com/atduskgreg/5100799).

## Install

Using Bundler:

```
gem "p5"
```

Via rubygems:

```
gem install p5
```

## Usage

First create a new Processing sketch folder on your server. This example assumes that you have a folder called `test_sketch`, with a file called `test_sketch.pde` in it, which holds this content.

```java
void setup()
{
	size(100, 100);
	ellipse(50, 50, 25, 25);
	saveFrame("grab.png");
	exit();
}
```

From Ruby, you can now run the sketch via this gem. You'll pass the name of the folder to P5, and it will automatically look for a `.pde` file inside of the folder of the same name.

```ruby
sketch = P5::Sketch.new("#{File.dirname(__FILE__)}/test_sketch")
sketch.run
```

This will compile and run the file in the `build` subfolder of the sketch folder. If you're on a webserver where you can only write to `/tmp` or something like it, you can pass in an output folder, where the sketch will be compiled and executed. The folder will automatically be created if it doesn't exist.

```ruby
sketch = P5::Sketch.new("#{File.dirname(__FILE__)}/test_sketch", "/tmp/abuildfolder")
sketch.run
```

If you're using Processing to generate images, like in this example, it's up to you to grab the images and upload them somewhere (e.g. S3). It's also up to you to delete the image again. In Sinatra, that would look something like this:

```ruby
get '/run' do
  folder = "#{File.dirname(__FILE__)}/test_sketch"
  sketch = P5::Sketch.new(folder)
  sketch.run
  file = File.join(folder, "grab.png")
  S3Object.store("grab.png", open(file), 'mybucket')
  File.delete(file)
  "Get your image at http://mybucket.s3.amazonaws.com/grab.png"
end
```

Of course, you would probably run the actual Processing run code in a background job, but you get the idea.

So what can you use this for? For example, all of this: https://vimeo.com/61113159

## Development

If you want to hack on this, please feel free to add features! The gem ships with a puppet recipe and a Vagrantfile, so it's super easy to get going:

```
$ git clone git://github.com/runemadsen/p5.git
$ cd p5
$ gem install vagrant
$ vagrant up
$ vagrant ssh
$ cd /vagrant
$ rvm use 2.0.0
$ rake test
```

If you want to contribute, please:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
