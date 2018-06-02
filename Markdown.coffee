
# dependencies
marked = require './lib/marked/marked.js'
require './lib/prism/prism.css'
require './lib/prism/prism.js'

# Component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Markdown'

  data: {
    content: ''
  }

  lifecycle: {
    mounted: ->
      for el in @find 'code'
        Prism.highlightElement el
        @hydrate el

  }

  template: (data) ->
    html = marked data.content, {headerIds: false}
    html = html.replace /"\s*lang-(.*)/g, '"language-$1'
    raw html

}
