
# dependencies
require './lib/jquery/jquery.fullpage.min.js'
require './lib/jquery/jquery.fullpage.min.css'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'FullPage'
  class: 'fullpage'

  lifecycle: {
    mounted: ->
      $(@el).fullpage @options
  }

  methods: {
    moveTo: (index, delay = 1) ->
      @setTimeout ( ->
        $.fn.fullpage.moveTo index
      ), delay

    setTimeout: (fn, delay) ->
      clearTimeout @timeout_id if @timeout_id
      @timeout_id = setTimeout fn, delay

  }

  template: (data, contents) ->
    contents()

}
