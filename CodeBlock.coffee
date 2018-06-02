
# dependencies
require './lib/prism/prism.css'
require './lib/prism/prism.js'

# component
module.exports = lemon.Component {
    package: 'lui'
    name: 'CodeBlock'
    class: 'code-block'

    data: {
      code: ''
      language: 'html'
    }

    lifecycle: {
      mounted: ->
        el = @findOne 'pre'
        Prism.highlightElement el
    }

    template: (data) ->
      pre ".language-#{data.language}", ->
        code ".language-#{data.language}", ->
          text data.code

  }
