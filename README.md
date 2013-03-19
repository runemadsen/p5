# P5

P5 is a ruby gem that makes it easy to run Processing sketches on a headless web server.

## What's in it, what's not

This gem ships with a full version of Processing, with all of the examples and UI components removed. It currently amounts to 30mb.

This gem does not ship with a version of xvfb, which is needed to run the gem. **You will need to install xvfb** in order to make this gem work. If you have a slice on Rackspace or something like this, it should be as easy as `apt-get install xvfb`. If you're on Heroku, [good luck](https://gist.github.com/atduskgreg/5100799).

## Usage

First create a new Processing sketch folder on your server. This example assumes that you have a folder called `test_sketch`, with a file called `test_sketch.pde` in it, which holds this content:

```
void setup()
{
	size(100, 100);
	ellipse(50, 50, 25, 25);
	saveFrame("grab.png");
	exit();
}

```

From Ruby, you can now run the sketch via this gem:

```
sketch = P5::Sketch.new("#{File.dirname(__FILE__)}/test_sketch")
sketch.run
```

This will compile and run the file in the `build` subfolder of the sketch folder. If you're on a webserver where you can only write to `/tmp` or something like it, you can pass in an output folder, where the sketch will be compiled and run. The folder will automatically be created if it doesn't exist.

```
sketch = P5::Sketch.new("#{File.dirname(__FILE__)}/test_sketch", "/tmp/abuildfolder")
sketch.run
```

So what can you use this for? For example, all of this: https://vimeo.com/61113159

## Development

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
