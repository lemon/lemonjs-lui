###
# credit: https://tympanus.net/Development/ButtonStylesInspiration/
###

# dependencies
require './lib/greensock/TweenMax.min.js'
require './css/Button.styl'

# template
module.exports = lemon.Component {
  package: 'lui'
  name: 'Button'
  class: 'lui-button'

  data: {
    color: 'purple'
    href: null
    text: null
  }

  methods: {
    onClick: (event) ->
      button = @el
      circle = button.querySelector('svg')
      ripple = button.querySelector('circle')
      timing = 0.75

      tl = new TimelineMax()
      x = event.offsetX
      y = event.offsetY
      w = event.target.offsetWidth
      h = event.target.offsetHeight
      offsetX = Math.abs( (w / 2) - x )
      offsetY = Math.abs( (h / 2) - y )
      deltaX = (w / 2) + offsetX
      deltaY = (h / 2) + offsetY
      scale_ratio = Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2))

      tl.fromTo ripple, timing, {
        x: x
        y: y
        transformOrigin: '50% 50%'
        scale: 0
        opacity: 1
        ease: Linear.easeIn
      }, {
        scale: scale_ratio,
        opacity: 0
      }
      return false
  }

  template: (data, contents) ->

    inner = ->
      button $click: 'onClick', 'data-color': data.color, ->
        if data.text
          text data.text
        if contents
          contents()
        tag 'svg', ->
          tag 'circle', cx: 1, cy: 1, r: 1

    if data.href
      a href: data.href, ->
        inner()
    else
      inner()

  }
