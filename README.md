Z App Rails App Template
========================

My current Rails app template.  Generates a nice skeleton app with many helpful customizations:

* Bootstrap and some custom clean metallic styling (bootstrap is non-vendored and in app/assets so you can augment)

* jquery ajax filter to add CSRF tokens to all requests

* SASS mixins galore (see app/assets/stylesheets/common)

* some nice flash message and error message partials and other view helpers (see app/helpers/application_helper.rb)

* some helpful utilities in [app]/lib (acts_as_reloadable to reload source files in [app]/lib on every request, a "reduce" validator to reduce multiple error messages on a single property to one message, etc).

* some @font-face fonts (see app/assets/fonts)

* some customizations to scaffolding (controller scaffolding DRYed up somewhat and augmented to include cancan auth checks; HAML view scaffolding adjusted to my liking with formtastic forms and other changes).

USAGE
-----
To use:

    $ rails new <new app name> -m <path to z_app.rb>