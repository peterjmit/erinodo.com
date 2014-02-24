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
      str = ""

      if @document.title
        str = "#{@document.title} :: "

      if @document.section
        section = @document.section.split('-').map((word) -> word.substr(0, 1).toUpperCase() + word.substr(1)).join(' ')
        str = "#{str}#{section}"

      if str
        "#{str} :: #{@site.title}"
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

    getNextProject: () ->
      if @getCollection(@document.section) and @document.isPage is false
        for document,documentIndex in @getCollection(@document.section).toJSON()
          if @document.id is document.id
            if documentIndex < @getCollection(@document.section).length - 1
              return @getCollection(@document.section).toJSON()[documentIndex + 1]
            else
              return null
      else
        return null

    getPrevProject: () ->
      if @getCollection(@document.section) and @document.isPage is false
        for document,documentIndex in @getCollection(@document.section).toJSON()
          if @document.id is document.id
            if documentIndex >= 1
              return @getCollection(@document.section).toJSON()[documentIndex-1]
            else
              return null
      else
        return null

  collections:
    # add some default meta data
    all: ->
      @getCollection("html").findAllLive().on "add", (model) ->
        model.setMetaDefaults({ layout: "default", isPage: false, sort: 0 })

    pages: ->
      @getCollection("html").findAllLive({ isPage: true })

    'scenic-painting': ->
      @getFilesAtPath("scenic-painting").findAllLive({ isPage: false }, [{ sort: 1 }])

    'art-direction': ->
      @getFilesAtPath("art-direction").findAllLive({ isPage: false }, [{ sort: 1 }])

    'fabrication': ->
      @getFilesAtPath("fabrication").findAllLive({ isPage: false }, [{ sort: 1 }])

    'puppets-and-masks': ->
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
