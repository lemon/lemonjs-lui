###
# credit: https://tympanus.net/Development/TextInputEffects/index.html
###

# dependencies
require './css/Input.styl'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'MailchimpInput'
  class: 'lui-input'

  data: {
    action: null
    bot_protection: null
    color: null
    events: {}
  }

  lifecycle: {
    mounted: ->
      @addEventListener @el, 'click', => @onClick()
      @el.setAttribute 'data-color', @color if @color

      if not @bot_protection
        @_warn '"bot_protection" is required'
      if not @action
        @_warn '"action" is required'
  }

  methods: {

    onClick: (e) ->
      @el.setAttribute 'data-filled', true
      @el.querySelector('input').focus()
      @events?.onClick? e

    onFocus: (e) ->
      @el.setAttribute 'data-filled', true
      @events.onFocus? e

    onBlur: (e) ->
      if @el.querySelector('input').value.trim() is ''
        @el.setAttribute 'data-filled', 'false'
      @events.onBlur? e

    onKeyUp: (e) ->
      if e.keyCode is 13
        @submit()
      @events.onKeyUp? e

    submit: (e) ->
      @$form.submit()
      @events.onSubmit? e

  }

  template: (data) ->
    {action, bot_protection} = data

    form ref: '$form', action: action, method: 'POST', ->
      input {
        $blur: 'onBlur'
        $focus: 'onFocus'
        $keyup: 'onKeyUp'
        name: 'EMAIL'
        type: "email"
        value: ''
      }
      div style: "position: absolute; left: -5000px;", 'aria-hidden': "true", ->
        input type: "text", name: bot_protection, tabindex: "-1", value: ""
      label ->
        tag 'svg', {
          width: "100%"
          height: "100%"
          viewBox: "0 0 404 77"
          preserveAspectRatio: "none"
        }, ->
          tag 'path', d: "m0,0l404,0l0,77l-404,0l0,-77z"
        span ->
          data.label

}
