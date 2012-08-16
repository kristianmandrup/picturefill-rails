# Picturefill View helpers for Rails

[picturefill](https://github.com/scottjehl/picturefill) is currently the best way for rendering [Responsive Images](http://5by5.tv/webahead/25) on a web page.

*picturefill-rails* provides nice view helper methods to render the picturefill.

```html
<div data-picture data-alt="A giant stone face at The Bayon temple in Angkor Thom, Cambodia">
    <div data-src="small.jpg"></div>
    <div data-src="small.jpg"         data-media="(min-device-pixel-ratio: 2.0)"></div>
    <div data-src="medium.jpg"        data-media="(min-width: 400px)"></div>
    <div data-src="medium_x2.jpg"     data-media="(min-width: 400px) and (min-device-pixel-ratio: 2.0)"></div>
    <div data-src="large.jpg"         data-media="(min-width: 800px)"></div>
    <div data-src="large_x2.jpg"      data-media="(min-width: 800px) and (min-device-pixel-ratio: 2.0)"></div>  
    <div data-src="extralarge.jpg"    data-media="(min-width: 1000px)"></div>
    <div data-src="extralarge_x2.jpg" data-media="(min-width: 1000px) and (min-device-pixel-ratio: 2.0)"></div> 

    <!-- Fallback content for non-JS browsers. Same img src as the initial, unqualified source element. -->
    <noscript>
        <img src="external/imgs/small.jpg" alt="A giant stone face at The Bayon temple in Angkor Thom, Cambodia">
    </noscript>
</div>
```   

The above can be rendered in Rails 3+ by writing the following code, using the View helpers provided by the Rails engine included: 

```haml
= picturefill 'A giant stone face at The Bayon temple in Angkor Thom, Cambodia' do
  = picture_src 'small.jpg'
  = picture_src 'small.jpg',     "(min-device-pixel-ratio: 2.0)"
  = picture_src 'medium.jpg',    "(min-width: 400px)"
  = picture_src 'medium_x2.jpg', "(min-width: 400px) and (min-device-pixel-ratio: 2.0)"
  = picture_src 'largs.jpg',     "(min-width: 800px)"
  = picture_src 'large_x2.jpg',  "(min-width: 800px) and (min-device-pixel-ratio: 2.0)"
  # ...
  = picture_fallback "external/imgs/small.jpg", alt: "A giant stone face at The Bayon temple in Angkor Thom, Cambodia" 
```

Note: This example uses [HAML](https://github.com/haml/haml) as the rendering engine.

### Optimizations using conventions

Using conventions, and an extra `ratio:` option, the following shorthand is possible:

```haml
= picturefill 'A giant stone face at The Bayon temple in Angkor Thom, Cambodia' do
  = picture_src 'small.jpg', ratio: 'x2'
  = picture_src 'medium.jpg', "400", ratio: 'x2'
  = picture_src 'large.jpg',  "800", ratio: 'x2'  
  # ...
  = picture_fallback "external/imgs/small.jpg", alt: "A giant stone face at The Bayon temple in Angkor Thom, Cambodia"
```

This will ouput exactly the same HTML as the previous example :)
See the specs for more details...

## Usage

In your Gemfile:

`gem 'picturefill-rails'`

A number of specs are included which all pass and should ensure that the view helpers work as expected.

## TODO

The `#picture_src` method works, but could use some heavy refactoring! I don't like methods of more than 10 lines! Is a bad sign. Reponsibilities should be off-loaded to other methods (or classes)

## Assets

The gem now also includes the picturefill javascript assets that are automatically available for the asset pipeline. In your `application.js` manifest file require:

* `picturefill.js`
* `picturefill\matchemedia.js`

See [demo](http://scottjehl.github.com/picturefill/) for a full example!

## jQuery Picture

[jquery picture](http://jquerypicture.com/) is now also partly supported. It is very similar to picturefill but with slightly different tags.

Assets `jquery-picture.min.js` and `jquery-picture.js` are included.

The view helper includes the view helper methods:

* `picture(alt)`
* `source(src, media, options = {})

```haml
= picture 'A giant stone face at The Bayon temple in Angkor Thom, Cambodia' do
  = source 'small.jpg', ratio: 'x2'
  = source 'medium.jpg', "400", ratio: 'x2'
  = source 'large.jpg',  "800", ratio: 'x2'  
  # ...
  = picture_fallback "external/imgs/small.jpg", alt: "A giant stone face at The Bayon 
```

And to enable:

```javascript
$(function(){
    $('picture').picture();
});
```

## Random Notes

[critique of picturefill](http://oscargodson.com/posts/picturefill-needs-to-die.html)

## Contributing to picturefill-rails
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Kristian Mandrup. See LICENSE.txt for
further details.

