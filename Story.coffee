
# styles
require './css/Story.styl'

# dependencies
require './Markdown'

# smooth scroll
require './lib/smooth-scroll/smoothscroll.js'

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Story'
  class: 'lui-story'

  data: {
    autonav: false
    include_search: true
    last_route: null
    last_update: Date.now()
    markdown: ''
    nav: []
    exclude: []
  }

  lifecycle: {

    mounted: ->
      lemon.on 'scroll', @onScroll
      @onScroll()

      if @autonav
        links = @$markdown.find 'a'
        nav = []
        for link in links
          href = link.pathname
          href += link.search if @include_search
          text = link.innerHTML
          is_title = link.parentNode.tagName.toLowerCase() is 'h1'
          if (text in @exclude) or (href in @exclude)
            continue
          if link.origin is location.origin
            nav.push {text, href, is_title}
        @nav = nav
        @last_route = Date.now() - 1000
        @updateActiveNav()

    beforeDestroy: ->
      lemon.off 'scroll', @onScroll

  }

  methods: {

    getHref: ->
      href = location.pathname
      href += location.search if @include_search
      return href

    goToSection: ->
      href = @getHref()
      el = @el.querySelector ".lui-story-content a[href='#{href}']"
      lemon.scrollTo el if el

    onRoute: (a, b, c) ->
      @last_route = Date.now() - 1000
      @updateActiveNav()
      @goToSection()
      @last_route = Date.now()

    updateActiveNav: (href) ->
      href ?= @getHref()
      return false if Date.now() - @last_route < 1000
      $match = @$sidebar.querySelector "a[href='#{href}']"
      return false if not $match
      return true if lemon.hasClass $match, 'active'

      # update selected element
      for $el in @find('a')
        lemon.removeClass $el, 'active'
      lemon.addClass $match, 'active'

      # scroll matched element to center
      $match.scrollIntoView {
        behavior: 'instant'
        block: 'center'
      }
      return true

    onScroll: (e) ->
      {_top, _bottom, height} = lemon.offset @el

      # adjust top
      @$sidebar.style.top = "#{_top}px"
      if _top > 0
        @$sidebar.scrollTop = 0

      # adjust bottom
      @$sidebar.style.bottom = "#{_bottom}px"
      if _bottom > 0
        @$sidebar.scrollTop = height

      # check for position in page to update active nav
      links = (link for link in @$markdown.find 'a')
      length = links.length
      for el, index in links.reverse()
        if (lemon.offset(el).top < 100 or index == length - 1)
          href = el.getAttribute 'href'
          return if @updateActiveNav href
  }

  routes: {
    '*': 'onRoute'
  }

  template: (data, contents) ->

    div '.lui-story-sidebar', ref: '$sidebar', ->
      div _list: 'nav', _template: (link) ->
        if link.is_title
          h3 ->
            a href: link.href, class: {active: link.is_active}, ->
              link.text
        else
          a href: link.href, class: {active: link.is_active}, ->
            link.text

    div '.lui-story-content', ->
      lui.Markdown {
        content: data.markdown or ''
        ref: '$markdown'
      }

}
