
# dependencies
require './css/Typewriter.styl'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Typewriter'
  class: 'typewriter'

  data: {
    active: 0
    delete_speed: 14
    state: 'static'
    text: []
    typing_speed: 70
  }

  computed: {
    is_complete: ->
      @state is 'static' and @active is @text.length - 1
  }

  watch: {
    state: (value) ->
      @animate()
  }

  methods: {
    animate: ->
      full_text = @text[@active]
      current = @el.innerHTML
      switch @state
        when 'reset'
          if current is ''
            @state = 'static'
          else
            current = current.substring 0, current.length - 1
            @el.innerHTML = current
            @setTimeout @animate, @delete_speed
        when 'deleting'
          if current == ''
            @state = 'typing'
          else
            current = current.substring(0, current.length - 1)
            @el.innerHTML = current
            @setTimeout @animate, @delete_speed
        when 'typing'
          if current == full_text
            @state = 'static'
            @onFinishTyping?(@active)
          else
            current = full_text.substring(0, current.length + 1)
            @el.innerHTML = current
            @setTimeout @animate, @typing_speed

    goto: (step, state = 'deleting') ->
      @active = Math.max(0, Math.min(step, @text.length - 1))
      @state = state

    next: ->
      @goto @active + 1

    prev: ->
      @goto @active - 1

    reset: ->
      @goto 0, 'reset'

    setTimeout: (fn, delay) ->
      clearTimeout @timeout_id if @timeout_id
      @timeout_id = setTimeout fn, delay

    start: ->
      @state = 'typing'

  }

  template: ->

}
