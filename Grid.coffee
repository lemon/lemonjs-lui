
# dependencies
require './css/Grid.styl'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Grid'
  class: 'lui-grid'

  data: {
    items: []
  }

  template: (data) ->
    for item in data.items
      div '.lui-grid-item', title: item.name, ->
        a '.inner', href: item.href, ->
          span ->
            if item.icon
              if typeof item.icon is 'function'
                div -> item.icon()
              else if i8?[item.icon]
                i8[item.icon] {class: 'icon', size: 65}
              else
                console.warn "you must require i8.#{item.icon} before using it"
            if item.name
              span -> item.name

}
