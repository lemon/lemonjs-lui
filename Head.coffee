
# dependencies
fs = require 'fs'
path = require 'path'

# exists helper
exists = (name) ->
  [fs.existsSync(path.resolve 'src', 'static', name), name]

# component
module.exports = lemon.Component {
  package: 'lui'
  name: 'Head'
  element: 'head'

  data: {
    charset: 'utf-8'
    css: ''
    description: ''
    dublin: null
    icon: null
    icon_114: null
    icon_144: null
    icon_57: null
    icon_72: null
    image: null
    keywords: null
    manifest: null
    opensearch: null
    robots: null
    site_name: null
    sitemap: null
    stylesheets: []
    title: ''
    url: null
    viewport: 'width=device-width,initial-scale=1,maximum-scale=5'
    exists: {
      dublin: exists 'Dublin.rdf'
      favicon: exists 'favicon.ico'
      icon: exists 'img/icon.png'
      icon_114: exists 'img/icon-114.png'
      icon_57: exists 'img/icon-57.png'
      icon_72: exists 'img/icon-72.png'
      manifest: exists 'manifest.json'
      opensearch: exists 'opensearch.xml'
      robots: exists 'robots.txt'
      sitemap: exists 'sitemap.txt'
    }
  }

  mount: ->

  template: (data, contents) ->

    # defaults
    data.url ?= page.url
    data.site_name ?= data.title
    for k, v of data.exists
      if not data[k] and v[0] is true
        data[k] = "#{site.origin}/#{v[1]}"

    # title
    if data.title
      title ->
        data.title

    # character set
    if data.charset
      meta charset: data.charset

    # viewport
    if data.viewport
      meta {name: 'viewport', content: data.viewport}

    # robots.txt
    if data.robots
      meta name: 'robots', content: data.robots

    # sitemap.xml
    if data.sitemap
      link {
        rel: 'sitemap'
        type: 'application/xml'
        title: 'Sitemap'
        href: data.sitemap
      }

    # dublin.rdf
    if data.dublin
      link {
        rel: 'meta'
        type: 'application/rdf+xml'
        title: 'Dublin'
        href: data.dublin
      }

    # search.xml
    if data.opensearch
      link {
        rel: 'search'
        type: 'application/opensearchdescription+xml'
        title: data.site_name
        href: data.opensearch
      }

    # manifest
    if data.manifest
      link rel: "manifest", href: data.manifest

    # application name
    if data.site_name
      meta name: 'application-name', content: data.site_name

    # favicon
    if data.icon
      link rel: 'shortcut icon', href: data.icon
      link rel: "icon", href: data.icon
      meta name: "msapplication-TileImage", content: data.icon

    # apple icons
    if data.icon_144
      link rel: "apple-touch-icon-precomposed", sizes: "144x144", href: data.icon_144
    if data.icon_114
      link rel: "apple-touch-icon-precomposed", sizes: "114x114", href: data.icon_114
    if data.icon_72
      link rel: "apple-touch-icon-precomposed", sizes: "72x72", href: data.icon_72
    if data.icon_57
      link rel: "apple-touch-icon-precomposed", href: data.icon_57

    # description
    if data.description
      meta name: 'description', content: data.description
      if data.description.length > 160
        console.log 'WARNING: meta description is too long. keep it under 160 characters.'

    # keywords
    if data.keywords
      if Array.isArray data.keywords
        meta name: 'keywords', content: data.keywords.join ', '
      else
        meta name: 'keywords', content: data.keywords

    ###
    # facebook og tags
    ###
    if data.locale
      meta property: 'og:locale', content: data.locale
    if data.site_name
      meta property: 'og:site_name', content: data.site_name
    if data.title
      meta property: 'og:type', content: 'website'
      meta property: 'og:title', content: data.title
    if data.image
      meta property: 'og:image', content: data.image
      meta property: 'og:image:type'
    if data.image_height
      meta property: 'og:image:height', content: data.image_height
    if data.image_width
      meta property: 'og:image:width', content: data.image_width
    if data.image and data.description
      meta property: 'og:image:alt', content: data.description
    if data.description
      meta property: 'og:description', content: data.description
    if data.url
      meta property: 'og:url', content: data.url

    ###
    # twitter card tags
    ###
    if data.title
      meta property: 'twitter:card', content: 'summary_large_image'
      meta property: 'twitter:title', content: data.title
    if data.image
      meta property: 'twitter:image:src', content: data.image
    if data.description
      meta property: 'twitter:description', content: data.description
    if data.image and data.description
      meta property: 'twitter:image:alt', content: data.description

    # ios
    meta name: 'apple-mobile-web-app-capable', content: 'yes'

    # custom css
    if data.stylesheets
      for url in data.stylesheets
        link href: url, rel: 'stylesheet', type: 'text/css'

    if data.css
      style data.css

    if contents
      contents()
}
