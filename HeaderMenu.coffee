###
# credit: https://tympanus.net/Development/LineMenuStyles/
###

# dependencies
require './css/HeaderMenu.styl'
require './lib/codrops/classie.js'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'HeaderMenu'
  class: 'lui-header-menu'

  data: {
    items: []
  }

  methods: {

    onRoute: ->
      {href, origin, pathname} = location
      resource = href.replace origin, ''

      if @$menu
        line = @$menu.querySelector '.line'
        links = @$menu.querySelectorAll 'a'
        offset = 0
        if links.length > 0
          for link in links
            lemon.removeClass link, 'active'
            if link.getAttribute('href') in [href, pathname, resource]
              lemon.addClass link, 'active'
              line.style.left = "#{offset + .2 * link.offsetWidth}px"
              line.style.width = "#{.6 * link.offsetWidth}px"
            offset += link.offsetWidth

  }

  routes: {
    '*': 'onRoute'
  }

  template: (data) ->
    div ->
      ul ref: '$menu', ->
        for item in data.items or []
          li ->
            a href: item.href, class: {active: item.active}, ->
              item.text
        div '.line', ref: '$line'

}
