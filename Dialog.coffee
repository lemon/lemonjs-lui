###
# credit: https://tympanus.net/Development/DialogEffects/wilma.html
###

require './css/Dialog.styl'
require './lib/codrops/dialogs/modernizr.custom.js'
require './lib/codrops/classie.js'
require './lib/codrops/dialogs/dialogFx.js'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Dialog'
  class: 'lui-dialog'

  data: {
    dialog: null
  }

  lifecycle: {
    mounted: ->
      @dialog = new DialogFx @el
  }

  methods: {
    toggle: ->
      @dialog.toggle()
  }

  template: (data, contents) ->
    div ".lui-dialog-overlay"
    div ".lui-dialog-content", ->
      div '.lui-morph-shape', ->
        tag 'svg', {
          xmlns: 'http://www.w3.org/2000/svg'
          width: '100%'
          height: '100%'
          viewBox: '0 0 560 280'
          preserveAspectRatio: 'none'
        }, ->
          tag 'rect', {
            x: "3"
            y: "3"
            fill: "none"
            width: "556"
            height: "276"
          }
      div ".lui-dialog-inner", ->
        if contents
          contents()
}
