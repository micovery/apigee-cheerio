## Cheerio.js for Apigee

This repo exposes the [cheerio.js](https://cheerio.js.org/) library re-packaged to make it work within an 
ES5 [Rhino JavaScript run-time](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Rhino) environment.

The main purpose of this repo is to offer a distribution that can be used within an 
[Apigee JavaScript policy](https://docs.apigee.com/api-platform/reference/policies/javascript-policy).


### Pre-built distribution

You can find pre-build distribution files over in the dist/ directory. You can grab these as-is, and use 
them in Apigee.


### Using in Apigee

In order to use the library in an Apigee JavaScript policy, you must refer to the library using
the `<IncludeURL>` element.

Here is an example JavaScript policy:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Javascript async="false" continueOnError="false" enabled="true" timeLimit="200" name="Cheerio">
    <DisplayName>Cheerio</DisplayName>
    <Properties/>
    <IncludeURL>jsc://cheerio.0.22.0.rhino.js</IncludeURL>
    <ResourceURL>jsc://my-business-logic.js</ResourceURL>
</Javascript>
```


Following from the example above, within the `my-business-logic.js`file you would be able to refer to the
global object `cheerio`, and write your own custom transformation logic.

For example:

```javascript
var $ = cheerio.load('           \n\
<ul id="fruits">                 \n\
  <li class="apple">Apple</li>   \n\
  <li class="orange">Orange</li> \n\
  <li class="pear">Pear</li>     \n\
</ul>');

$('li.apple').text('Banana');
$('li.apple').addClass('banana');
$('li.apple').removeClass('apple');

print($.html());
```



### Build Prerequisites

  * Bash shell (your OS must have bash)
  * [Install Docker](https://docs.docker.com/install/)
  

The build process itself runs inside docker, so it should work well across different operating
systems a long as you have both bash, and docker installed in your system.

### Building it

If you want to build the library yourself (as opposed to using the pre-built files in the `dist` directory), use the 
following command:

```bash
 MODE=development BRANCH=master ./build.sh
```

In the example above, I am showing how to build the library in development mode, from the Cheerio master branch.

The `MODE` environment variable maps directly to the `mode` property in webpack. Supported modes are: `production` and `development`. When you build in `production` mode, the resulting build output is
minified. When you build in `development` mode, the resulting build output is not minified.

The `BRANCH` environment variable specifies which Git branch is checked-out after the Cheerio repo is cloned during
the build process. You can specify actual branch names, or even tag names from the Cheerio repo. See the full list of
tags over at https://github.com/cheeriojs/cheerio/tags.


### Not Google Product Clause

This is not an officially supported Google product.