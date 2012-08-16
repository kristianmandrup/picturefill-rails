# Picturefill View helpers for Rails

[picturefill](https://github.com/scottjehl/picturefill) is currently the best "hack" for rendering Responsive Images on a web page.

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

Can now be written like this, using the provided View helpers: 

```haml
= picturefill 'A giant stone face at The Bayon temple in Angkor Thom, Cambodia' do
  = pic_src 'small.jpg'
  = pic_src 'small.jpg',     "(min-device-pixel-ratio: 2.0)"
  = pic_src 'medium.jpg',    "(min-width: 400px)"
  = pic_src 'medium_x2.jpg', "(min-width: 400px) and (min-device-pixel-ratio: 2.0)"
```

## Convenience functionality

Obviously there is huge potential to cut down on the bloat here by taking advantage of common conventions. Fx if the image src name ends in fx `_x2` it should auto-concatenate 
`(min-device-pixel-ratio: 2.0)` to the `data-media` attribute.

If you use a `ratio: 'x2'` option to `#pic_src` it should auto-generate the complete 'x2' version of the image source using this convention.

### Optimized

Using the convenience functionality:

```haml
= picturefill 'A giant stone face at The Bayon temple in Angkor Thom, Cambodia' do
  = pic_src 'small.jpg', ratio: 'x2'
  = pic_src 'medium.jpg', "400", ratio: 'x2'
  = pic_src 'large.jpg',  "800", ratio: 'x2'  
```

Please help contribute this functionality ;)

PS: Currently not tested and code needs to be refactored somewhat...

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

