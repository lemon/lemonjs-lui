
# css
require './css/Footer.styl'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Footer'
  class: 'lui-footer'

  template: (data, contents) ->
    if contents
      contents()
}
