# DocPad Configuration File
# http://docpad.org/docs/config

docpadConfig =
  templateData:
    site:
      url: "http://erinodo.com"
      title: "Erin O'Donnell :: Scenic Painting - Specialty Fabricator - Puppets"
      description: """
        Erin O'Donnell is a puppet fabricator, prop fabricator and scenic painter
        for film television and theatre
      """
      author: "Erin O'Donnell"
      email: "erin@erinodo.com"
      keywords: "Scenic Painting, Specialty Fabricator, Puppets, Art Director"

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

    getPrimaryImage: (project) ->
      "/img/#{project.section}/#{project.primary_image}"

  collections:
    # add some default meta data
    all: ->
      @getCollection("html").findAllLive().on "add", (model) ->
        model.setMetaDefaults({ layout: "default", isPage: false, sort: 0 })

    pages: ->
      @getCollection("html").findAllLive({ isPage: true })

    scenicPainting: ->
      @getFilesAtPath("scenic-painting").findAllLive({ isPage: false }, [{ sort: 1 }])

    artDirection: ->
      @getFilesAtPath("art-direction").findAllLive({ isPage: false }, [{ sort: 1 }])

    fabrication: ->
      @getFilesAtPath("fabrication").findAllLive({ isPage: false }, [{ sort: 1 }])

    puppetsAndMasks: ->
      @getFilesAtPath("puppets-and-masks").findAllLive({ isPage: false }, [{ sort: 1 }])

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

  plugins:
    thumbnails:
      imageMagick: true
      extensions: ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF']
      presets:
        'default':
          w: 330
          h: 330
      targets:
        'default': 'zoomcrop'

# Export the DocPad Configuration
module.exports = docpadConfig
