# Quantify JSON to FCP XML Converter

Convert JSON data exported from Quantify to FCP XML format.

# Step-by-step How-To

## Mac OS X Instructions


### First-time Setup

Launch Terminal.app (in /Applications/Utilities). Copy-paste the following into the Terminal window and press enter after the Terminal comes to rest on the last line:

```sh
curl -L https://github.com/storyandpixel/quantify-json-to-fcp-xml-converter/archive/master.zip --output quantify-json-converter.zip
unzip quantify-json-converter.zip
cd quantify-json-to-fcp-xml-converter-master/
sudo gem install bundler
bundle install
```

### Conversion Process

Now you're all set and ready to convert your first file. Here's how:

1. Type (or copy-paste the following) into the terminal window: `bundle exec ruby convert.rb`
2. Add a space after `convert.rb`.
3. Switch to Finder and locate the .json file you exported from Quantify. Drag and drop the .json file onto the Terminal window. This will add the path to the file at the end of the terminal command. So your command should now look something like `bundle exec ruby convert.rb /Users/jedidiah/Downloads/2015-09-10-car-ride-with-Ish.json`.
4. Press the enter key.

If all went well, you should see a new .xml final appear next to the .json file. You're all done! You may now proceed to import this .xml file into any program that recognizes Final Cut XML files.

### Converting More Files Later

In order to convert more files later, you simply need to re-launch Terminal.app, type (or copy-paste) `cd quantify-json-to-fcp-xml-converter-master/`, hit enter, then follow the steps under **Conversion Process** again.

### Updating The Script

If we make changes to this script and you would like to update your copy, simply move the `quantify-json-to-fcp-xml-converter-master` folder into your Trash (the ` quantify-json-to-fcp-xml-converter-master` folder will be in your home folder) and then follow the **First-time Setup** instructions again.

## Windows Instructions

We'll write these up if there's interest. Let us know.
