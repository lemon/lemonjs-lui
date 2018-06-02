
# css
require './css/Header.styl'

# dependencies
require './HeaderMenu'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Header'
  class: 'lui-header'

  data: {
    logo_href: '/'
    logo: null
    nav: []
  }

  template: (data, contents) ->

    # logo
    {logo, logo_href} = data
    if logo
      a '.logo', href: logo_href, ->
        if /\\.(png|jpg|svg)/.test logo
          img src: logo
        else
            logo

    # navigation
    lui.HeaderMenu {
      class: 'nav'
      items: data.nav
    }

}
