# DocPad Configuration File
# http://docpad.org/docs/config

docpadConfig =
  templateData:
    site:
      url: "http://erinodonnell.ca"
      title: "Erin O'Donnell :: Specialist Fabricator"
      description: """
        Erin O'Donnell
      """
      author: "Erin O'Donnell"
      email: "erin@erinodonnell.co"
      keywords: ""

    # Helper data
    getPageTitle: ->
      if @document.title
        "#{@document.title} :: #{@site.title}"
      else
        @site.title

    getMetaDescription: -> @document.description or @site.description

    getMetaKeywords: -> @site.keywords.concat(@document.tags or []).join(", ")

    getBodyClass: -> @document.bodyClass or ""

    isActiveNav: (section) ->
      if @document.section == section
        "active"
      else
        ""

  collections:
    # add some default meta data
    all: ->
      @getCollection("html").findAllLive().on "add", (model) ->
        model.setMetaDefaults({ layout: "default", isPage: false })

    pages: ->
      @getCollection("html").findAllLive({ isPage: true })

  events:
    writeAfter: (opts, next) ->
      # Prepare
      safeps = require('safeps')
      pathUtil = require('path')
      docpad = @docpad
      rootPath = docpad.getConfig().rootPath
      gruntPath = pathUtil.join('grunt')

      command = [gruntPath, 'default']

      # Execute
      safeps.spawn(command, { cwd: rootPath, output:true }, next)

      # Chain
      @

# Export the DocPad Configuration
module.exports = docpadConfig
