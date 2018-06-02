###
# credit: https://tympanus.net/Development/TextInputEffects/index.html
###

# dependencies
require './css/Input.styl'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Input'
  class: 'lui-input'

  lifecycle: {
    mounted: ->
      @addEventListener @el, 'click', => @_onClick()
      @el.setAttribute 'data-color', @color if @color
  }

  computed: {
    value: ->
      @$input.value

  }

  methods: {

    _onClick: (e) ->
      @el.setAttribute 'data-filled', true
      @el.querySelector('input').focus()
      @_parent._apply @onClick, [e]

    _onFocus: (e) ->
      @el.setAttribute 'data-filled', true
      @_parent._apply @onFocus, [e]

    _onKeyUp: (e) ->
      @_parent._apply @onKeyUp, [e]

    _onBlur: (e) ->
      if @el.querySelector('input').value.trim() is ''
        @el.setAttribute 'data-filled', 'false'
      @_parent._apply @onBlur, [e]

  }

  template: (data) ->
    input {
      ref: '$input'
      type: "text"
      $focus: '_onFocus'
      $keyup: '_onKeyUp'
      $blur: '_onBlur'
    }
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
