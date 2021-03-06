import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import TextareaAutogrow from "stimulus-textarea-autogrow"
import CharacterCounter from "stimulus-character-counter"
import NestedForm from "stimulus-rails-nested-form"
import ReadMore from "stimulus-read-more"

const application = Application.start(document.documentElement)
const context = require.context('.', true, /_controller\.js$/)
application.load(definitionsFromContext(context))
application.register("textarea-autogrow", TextareaAutogrow)
application.register("character-counter", CharacterCounter)
application.register("nested-form", NestedForm)
application.register("read-more", ReadMore)
