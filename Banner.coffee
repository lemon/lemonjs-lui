
# css
require './css/Banner.styl'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Banner'
  class: 'lui-banner'

  data: {
    title: ''
    subtitle: ''
    buttons: []
  }

  template: (data, contents) ->

    if data.title
      h1 ->
        data.title

    if data.subtitle
      p ->
        data.subtitle

    if data.buttons
      for btn in data.buttons
        a class: {active: btn.active or false}, href: btn.href, ->
          btn.text

}
